import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:right_routes/core/routes/all_routes.dart';
import 'package:right_routes/global_widgets/custom_navbar.dart';
import 'package:right_routes/utils/assets_manager.dart';
import 'package:right_routes/utils/colors.dart';

// ========== GetX Controller for Voice Recording ==========
// Purpose: Handle voice recording state and text input
class EnterDirectionsController extends GetxController {
  RxBool isRecording = false.obs;
  final TextEditingController textController = TextEditingController();

  void toggleRecording() {
    isRecording.value = !isRecording.value;
    if (isRecording.value) {
      // Start voice recording
      print('Recording started...');
    } else {
      // Stop voice recording
      print('Recording stopped');
    }
  }

  @override
  void onInit() {
    super.onInit();
    // Pre-fill with sample data
    textController.text = 'I-29 S\nExit 63A-B\nExit 63B\nI-94 W';
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}

class EnterDirections extends StatelessWidget {
  const EnterDirections({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EnterDirectionsController());

    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
              // ========== Fixed Logo Section ==========
              Center(
                child: Container(
                  width: 220,
                  height: 110,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(ImageManager.splashScreenLogo),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              // ========== Scrollable Content Section ==========
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 29),
                      // ========== Title with Info Icon ==========
                      Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                'ENTER DIRECTIONS',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontFamily: 'League Gothic',
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),

                      // ========== First Instruction Paragraph ==========
                      Text(
                        "This app uses your current location as the starting point for your route. Before creating your route,make sure you're at the location you will start hauling from",

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 4),

                      // ========== Second Instruction with Info Icon ==========
                      Text(
                        'Type or Speak in your way points separated by ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'commas.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.02),

                          // ========== Info Icon Button ==========
                          GestureDetector(
                            onTap: () {
                              showEnterDirectionsInfoDialog(context);
                            },
                            child: Center(
                              child: SvgPicture.asset(
                                "assets/icons/Question-Box-gray.svg",
                                width: 20,
                                height: 20,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20),

                      // ========== Text Input Field with Microphone ==========
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
                            // ========== Text Field ==========
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
                                  hintText: 'Enter directions here...',
                                  hintStyle: TextStyle(
                                    color: Color(0xFF999999),
                                    fontSize: 20,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),

                            // ========== Microphone Button (Bottom Right) ==========
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

                      // ========== Bottom Action Buttons Row ==========
                      Row(
                        children: [
                          // ========== Back Button ==========
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
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
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Spacer(),

                          // ========== Continue Button ==========
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
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 130),
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

// ========== DIALOG FUNCTION ==========
void showEnterDirectionsInfoDialog(BuildContext context) {
  // Get screen dimensions
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.only(
          top: 60,
          bottom: 100,
          left: 20,
          right: 20,
        ),
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
                // ========== Header: Mic + Keyboard Icons + Close ==========
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // ========== Left Icons (Mic + Keyboard) ==========
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/Edit-Pencil-white.svg",
                          width: 24,
                          height: 24,
                        ),
                        SizedBox(width: 12),
                        Icon(Icons.mic, color: Colors.white, size: 24),
                      ],
                    ),

                    // ========== Close Button ==========
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: SvgPicture.asset(
                        "assets/icons/Close-X-Circle.svg",
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),

                // ========== Dialog Content ==========
                Text(
                  "Enter your route following one of the two ways shown above:\n\n"
                  "Typing: Enter route information like \"drive 400 feet\" or \"mile 5.8 & 5.9\". Keep it simple.\n\n"
                  "Type it:\n"
                  "Tap inside the text field below and use your device's keyboard to enter the route.\n\n"
                  "I-29 S\n"
                  "Exit 63A-B\n"
                  "Exit 63B\n"
                  "exit 340\n"
                  "I-94 W\n\n"
                  "Speak it:\n"
                  "Tap the microphone icon to begin and speak in the format below. The mic will turn red when active.\n\n"
                  "The text will appear in the text field.\n\n"
                  "I 29 south  LINE\n"
                  "Exit 63 A B  LINE\n"
                  "Exit 63 B  LINE\n"
                  "Exit 6 3 B  LINE\n"
                  "exit 340\n\n"
                  "Tap the microphone icon to stop.\n\n"
                  "Edit as needed before tapping the Continue button.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w500,
                    height: 1.44,
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
