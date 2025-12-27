import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:right_routes/core/routes/all_routes.dart';
import 'package:right_routes/global_widgets/custom_navbar.dart';
import 'package:right_routes/utils/assets_manager.dart';
import 'package:right_routes/utils/colors.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';
import 'package:avatar_glow/avatar_glow.dart';

// ========== PROFESSIONAL VOICE CONTROLLER ==========
class EnterDirectionsController extends GetxController {
  final TextEditingController textController = TextEditingController();

  // Observable States
  RxBool isRecording = false.obs;
  RxBool speechInitialized = false.obs;
  RxString currentRecognizedText = ''.obs;
  RxInt retryCount = 0.obs;

  late stt.SpeechToText speech;

  // ✅ Professional Configuration Constants
  static const int MAX_RETRY_ATTEMPTS = 3;
  static const int MAX_LISTEN_DURATION_MINUTES = 1;
  static const int PAUSE_DURATION_SECONDS = 3;
  static const int AUTO_RESTART_DELAY_SECONDS = 2;

  @override
  void onInit() {
    super.onInit();
    _initializeSpeech();
  }

  // ========== SPEECH INITIALIZATION ==========
  Future<void> _initializeSpeech() async {
    try {
      speech = stt.SpeechToText();

      print('🎤 Checking microphone permission...');
      final status = await Permission.microphone.request();
      print('🎤 Permission status: $status');

      if (status.isGranted) {
        await _setupSpeechRecognition();
      } else if (status.isPermanentlyDenied) {
        print('❌ Permission permanently denied');
        _showPermissionDialog();
      } else {
        print('❌ Permission denied');
        _showError('Permission Required', 'Microphone permission is required for voice input');
      }
    } catch (e) {
      print('❌ Init error: $e');
      _showError('Initialization Error', 'Failed to initialize speech recognition');
    }
  }

  Future<void> _setupSpeechRecognition() async {
    print('🎤 Setting up speech recognition...');

    bool available = await speech.initialize(
      onError: (error) => _handleSpeechError(error),
      onStatus: (status) => _handleSpeechStatus(status),
    );

    speechInitialized.value = available;

    if (available) {
      print('✅ Speech recognition ready!');
      retryCount.value = 0;
    } else {
      print('❌ Speech recognition not available');
      _showError('Not Available', 'Speech recognition is not available on this device');
    }
  }

  // ========== ERROR HANDLING WITH AUTO-RETRY ==========
  void _handleSpeechError(dynamic error) {
    print('❌ Speech error: ${error.errorMsg}');

    if (isRecording.value && retryCount.value < MAX_RETRY_ATTEMPTS) {
      retryCount.value++;
      print('🔄 Auto-retry attempt ${retryCount.value}/$MAX_RETRY_ATTEMPTS');

      Future.delayed(Duration(seconds: AUTO_RESTART_DELAY_SECONDS), () {
        if (isRecording.value) {
          _restartListening();
        }
      });
    } else {
      isRecording.value = false;
      retryCount.value = 0;

      // ✅ Auto-close on error
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }

      _showError('Voice Error', error.errorMsg);
    }
  }

  // ========== STATUS HANDLING WITH AUTO-CLOSE ==========
  void _handleSpeechStatus(String status) {
    print('🎤 Speech status: $status');

    switch (status) {
      case 'listening':
        break;

      case 'notListening':
        if (isRecording.value && retryCount.value < MAX_RETRY_ATTEMPTS) {
          print('🔄 Connection lost, auto-restarting...');
          Future.delayed(Duration(seconds: 1), () {
            if (isRecording.value) {
              _restartListening();
            }
          });
        } else {
          // ✅ Auto-close and save
          _finalizeRecording();
        }
        break;

      case 'done':
      // ✅ Auto-close and save
        _finalizeRecording();
        break;
    }
  }

  // ========== FINALIZE RECORDING (AUTO-CLOSE) ==========
  void _finalizeRecording() {
    isRecording.value = false;
    retryCount.value = 0;

    Future.delayed(Duration(milliseconds: 300), () {
      // ✅ Auto-add recognized text
      if (currentRecognizedText.value.isNotEmpty) {
        _processAndAddText(currentRecognizedText.value);
      }

      currentRecognizedText.value = '';

      // ✅ Auto-close dialog
      if (Get.isDialogOpen ?? false) {
        Get.back();

        // ✅ Show success message at TOP
        if (textController.text.isNotEmpty) {
          Get.snackbar(
            'Success',
            'Voice input added successfully',
            backgroundColor: Colors.green.withOpacity(0.9),
            colorText: Colors.white,
            icon: Icon(Icons.check_circle_outline, color: Colors.white),
            snackPosition: SnackPosition.TOP, // ✅ TOP position
            duration: Duration(seconds: 2),
            margin: EdgeInsets.all(10),
          );
        }
      }
    });
  }

  // ========== AUTO-RESTART LISTENING ==========
  Future<void> _restartListening() async {
    try {
      await speech.stop();
      await Future.delayed(Duration(milliseconds: 500));

      await speech.listen(
        onResult: _processResult,
        listenFor: Duration(minutes: MAX_LISTEN_DURATION_MINUTES),
        pauseFor: Duration(seconds: PAUSE_DURATION_SECONDS),
        partialResults: true,
        localeId: 'en_US',
        cancelOnError: false,
      );

      print('✅ Listening restarted successfully');
    } catch (e) {
      print('❌ Restart failed: $e');
      retryCount.value++;
      if (retryCount.value < MAX_RETRY_ATTEMPTS) {
        _restartListening();
      }
    }
  }

  // ========== TOGGLE RECORDING ==========
  Future<void> toggleRecording() async {
    print('🎤 Toggle recording: ${isRecording.value}');

    if (!speechInitialized.value) {
      _showError('Not Ready', 'Please restart the app and grant microphone permission');
      return;
    }

    if (isRecording.value) {
      await stopRecording();
    } else {
      await startRecording();
    }
  }

  // ========== START RECORDING ==========
  Future<void> startRecording() async {
    try {
      print('🎤 Starting recording...');
      isRecording.value = true;
      currentRecognizedText.value = '';
      retryCount.value = 0;

      showListeningDialog();

      await speech.listen(
        onResult: _processResult,
        listenFor: Duration(minutes: MAX_LISTEN_DURATION_MINUTES),
        pauseFor: Duration(seconds: PAUSE_DURATION_SECONDS),
        partialResults: true,
        localeId: 'en_US',
        cancelOnError: false,
      );

      print('✅ Recording started');
    } catch (e) {
      print('❌ Start error: $e');
      isRecording.value = false;
      if (Get.isDialogOpen ?? false) Get.back();
      _showError('Recording Error', 'Failed to start recording');
    }
  }

  // ========== PROCESS RESULT ==========
  void _processResult(result) {
    print('🎤 Result: ${result.recognizedWords} (Final: ${result.finalResult})');
    currentRecognizedText.value = result.recognizedWords;

    if (result.finalResult && result.recognizedWords.isNotEmpty) {
      _processAndAddText(result.recognizedWords);
      currentRecognizedText.value = '';
    }
  }

  // ========== PROCESS AND ADD TEXT ==========
  void _processAndAddText(String recognizedText) {
    if (recognizedText.isEmpty) return;

    String processedText = recognizedText
        .replaceAll(RegExp(r'\bline\b', caseSensitive: false), '\n')
        .replaceAll(RegExp(r'\bnew line\b', caseSensitive: false), '\n')
        .replaceAll(RegExp(r'\bbreak\b', caseSensitive: false), '\n');

    processedText = _expandAbbreviations(processedText);
    processedText = _cleanText(processedText);

    if (processedText.isNotEmpty) {
      if (textController.text.isNotEmpty && !textController.text.endsWith('\n')) {
        textController.text += '\n';
      }

      textController.text += processedText;

      textController.selection = TextSelection.fromPosition(
        TextPosition(offset: textController.text.length),
      );

      print('✅ Added: $processedText');
    }
  }

  // ========== EXPAND ABBREVIATIONS ==========
  String _expandAbbreviations(String text) {
    return text
        .replaceAllMapped(
      RegExp(r'\b(SB|southbound)\b', caseSensitive: false),
          (match) => 'S',
    )
        .replaceAllMapped(
      RegExp(r'\b(NB|northbound)\b', caseSensitive: false),
          (match) => 'N',
    )
        .replaceAllMapped(
      RegExp(r'\b(EB|eastbound)\b', caseSensitive: false),
          (match) => 'E',
    )
        .replaceAllMapped(
      RegExp(r'\b(WB|westbound)\b', caseSensitive: false),
          (match) => 'W',
    )
        .replaceAllMapped(
      RegExp(r'\bInterstate\s+(\d+)', caseSensitive: false),
          (match) => 'I-${match.group(1)}',
    )
        .replaceAllMapped(
      RegExp(r'\bHighway\s+(\d+)', caseSensitive: false),
          (match) => 'Hwy ${match.group(1)}',
    );
  }

  // ========== CLEAN TEXT ==========
  String _cleanText(String text) {
    return text
        .trim()
        .replaceAll(RegExp(r'\s+'), ' ')
        .replaceAll(RegExp(r'\n\s+'), '\n')
        .replaceAll(RegExp(r'\n{3,}'), '\n\n');
  }

  // ========== STOP RECORDING ==========
  Future<void> stopRecording() async {
    try {
      print('🎤 Stopping recording...');
      await speech.stop();
      isRecording.value = false;

      // ✅ Auto-add current text
      if (currentRecognizedText.value.isNotEmpty) {
        _processAndAddText(currentRecognizedText.value);
      }

      currentRecognizedText.value = '';
      retryCount.value = 0;

      // ✅ Auto-close dialog
      if (Get.isDialogOpen ?? false) {
        Get.back();

        // ✅ Show success message at TOP
        if (textController.text.isNotEmpty) {
          Get.snackbar(
            'Success',
            'Voice input added successfully',
            backgroundColor: Colors.green.withOpacity(0.9),
            colorText: Colors.white,
            icon: Icon(Icons.check_circle_outline, color: Colors.white),
            snackPosition: SnackPosition.TOP, // ✅ TOP position
            duration: Duration(seconds: 2),
            margin: EdgeInsets.all(10),
          );
        }
      }
    } catch (e) {
      print('❌ Stop error: $e');
    }
  }

  // ========== LISTENING DIALOG (NO CLOSE ICON) ==========
  void showListeningDialog() {
    Get.dialog(
      WillPopScope(
        onWillPop: () async {
          await stopRecording();
          return true;
        },
        child: Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(34), // ✅ Uniform padding
            decoration: BoxDecoration(
              color: Color(0xFF2E3746),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ✅ Avatar Glow Animation
                Obx(() => AvatarGlow(
                  glowColor: Colors.red,
                  glowRadiusFactor: 0.6,
                  duration: Duration(milliseconds: 2000),
                  repeat: true,
                  animate: isRecording.value,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isRecording.value
                          ? Colors.red.withOpacity(0.3)
                          : Colors.grey.withOpacity(0.3),
                    ),
                    child: Icon(
                      Icons.mic,
                      size: 40,
                      color: isRecording.value ? Colors.red : Colors.grey,
                    ),
                  ),
                )),

                SizedBox(height: 24),

                // Recognized Text
                Obx(() => Container(
                  constraints: BoxConstraints(minHeight: 60, maxHeight: 100),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Text(
                        currentRecognizedText.value.isEmpty
                            ? 'Listening...'
                            : currentRecognizedText.value,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                )),

                SizedBox(height: 8),

                Text(
                  'Say "LINE" for line break',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),

                SizedBox(height: 4),

                Text(
                  'Auto-stops after ${MAX_LISTEN_DURATION_MINUTES} minute',
                  style: TextStyle(color: Colors.white60, fontSize: 12),
                ),

                SizedBox(height: 24),

                // ✅ Stop Button
                GestureDetector(
                  onTap: () => stopRecording(),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withOpacity(0.4),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.stop, color: Colors.white, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Stop',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  // ========== HELPER METHODS ==========
  void _showError(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.red.withOpacity(0.8),
      colorText: Colors.white,
      icon: Icon(Icons.error_outline, color: Colors.white),
      snackPosition: SnackPosition.TOP, // ✅ TOP position
      duration: Duration(seconds: 3),
      margin: EdgeInsets.all(10),
    );
  }

  void _showPermissionDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.mic_off, size: 64, color: Colors.red),
              SizedBox(height: 16),
              Text(
                'Microphone Permission Required',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text(
                'Please enable microphone permission in your device settings.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Get.back(),
                      child: Text('Cancel'),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                        openAppSettings();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.orange,
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        'Open Settings',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onClose() {
    textController.dispose();
    speech.stop();
    super.onClose();
  }
}

// ========== MAIN SCREEN ==========
class EnterDirections extends StatelessWidget {
  const EnterDirections({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EnterDirectionsController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageManager.mapBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 4),
              Center(
                child: Container(
                  width: 220,
                  height: 110,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(ImageManager.splashScreenLogo),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 26),

                      Center(
                        child: Text(
                          'ENTER DIRECTIONS',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 33,
                            fontFamily: 'League Gothic',
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                      SizedBox(height: 9),

                      Text(
                        "This app uses your current location as the starting point for your route. Before creating your route, make sure you're at the location you will start hauling from.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w500,
                          height: 1.4,
                        ),
                      ),
                      SizedBox(height: 12),

                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w500,
                            height: 1.4,
                          ),
                          children: [
                            TextSpan(
                              text: 'Enter your route following one of the two samples below. Don\'t add extra information like "drive 400 feet" or "mile post 84.48." Keep it simple. ',
                            ),
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: GestureDetector(
                                onTap: () {
                                  showEnterDirectionsInfoDialog(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: SvgPicture.asset(
                                    "assets/icons/Question-Box-gray.svg",
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),

                      Container(
                        width: double.infinity,
                        height: 246,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            left: BorderSide(
                              color: Color(0xFF1A2332),
                              width: 3,
                            ),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: 15,
                                top: 17,
                                right: 15,
                                bottom: 50,
                              ),
                              child: TextField(
                                controller: controller.textController,
                                maxLines: null,
                                expands: true,
                                cursorColor: AppColors.black,
                                textAlignVertical: TextAlignVertical.top,
                                style: TextStyle(
                                  color: Color(0xFF141414),
                                  fontSize: 20,
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.w500,
                                  height: 1.40,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                showCursor: true,
                              ),
                            ),

                            Positioned(
                              bottom: 12,
                              right: 15,
                              child: Obx(
                                    () => GestureDetector(
                                  onTap: () => controller.toggleRecording(),
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: controller.isRecording.value
                                          ? Colors.red.withOpacity(0.1)
                                          : Colors.transparent,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.mic,
                                      size: 28,
                                      color: controller.isRecording.value
                                          ? Colors.red
                                          : AppColors.medGray,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),

                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => Get.back(),
                            child: Container(
                              width: 57,
                              height: 24,
                              decoration: BoxDecoration(
                                color: AppColors.orange,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  'Back',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.editConfirmStartYourRoute);
                            },
                            child: Container(
                              width: 76,
                              height: 24,
                              decoration: BoxDecoration(
                                color: AppColors.orange,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  'Continue',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 250),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavbar(),
    );
  }
}

// ========== INFO DIALOG ==========
void showEnterDirectionsInfoDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.only(top: 60, bottom: 100, left: 20, right: 20),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Color(0xFF4A4A4A),
            borderRadius: BorderRadius.circular(12),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset("assets/icons/Edit-Pencil-white.svg", width: 24, height: 24),
                        SizedBox(width: 12),
                        Icon(Icons.mic, color: Colors.white, size: 24),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: SvgPicture.asset("assets/icons/Close-X-Circle.svg", width: 24, height: 24),
                    ),
                  ],
                ),
                SizedBox(height: 16),

                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w500,
                      height: 1.44,
                    ),
                    children: [
                      TextSpan(text: 'Type it:\n', style: TextStyle(fontWeight: FontWeight.w700)),
                      TextSpan(text: 'Tap inside the text field below and use your device\'s keyboard to enter the directions in this format:\n\n'),
                      TextSpan(
                        text: 'I-29 S\nExit 63А-В\nExit 63В\nI-94 W\nExit 340\n\n',
                        style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white.withOpacity(0.9)),
                      ),
                      TextSpan(text: 'Speak it:\n', style: TextStyle(fontWeight: FontWeight.w700)),
                      TextSpan(text: 'Tap the microphone icon to begin and speak in the format below. The mic will turn red when active.\n\n'),
                      TextSpan(text: 'The text will appear in the text field.\n\n'),
                      TextSpan(
                        text: 'I 29 south  LINE\nExit 63 A B  LINE\nExit 63 B  LINE\nI94 west  LINE\nexit 340\n\n',
                        style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white.withOpacity(0.9)),
                      ),
                      TextSpan(text: 'Tap the microphone icon to stop dictation.\n\n'),
                      TextSpan(text: 'Edit as needed before tapping the Continue button.'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}