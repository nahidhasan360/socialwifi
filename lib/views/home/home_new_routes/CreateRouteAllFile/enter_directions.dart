import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
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

    return Scaffold(
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
              // Purpose: Company branding logo at top
              // Size: 225x112 (fixed)
              Center(
                child: Container(
                  width: 225,
                  height: 112,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(ImageManager.splashScreenLogo),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32.h),

              // ========== Scrollable Content Section ==========
              // Purpose: Main content area
              // Padding: 22.w horizontal
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 22.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ========== Title with Info Icon ==========
                      // Purpose: Page heading with information indicator
                      // Font: League Gothic, 32sp, White
                      Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                'ENTER DIRECTIONS',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontFamily: 'League Gothic',
                                  fontWeight: FontWeight.w400,
                                  height: 0.88,
                                  letterSpacing: 1.50,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),

                      // ========== First Instruction Paragraph ==========
                      // Purpose: Explain starting location usage
                      // Font: Lato, 18sp, White, line height 1.44
                      Text(
                        "This app uses your current location as the starting point for your route. Before creating your route, make sure you're at the location you will start hauling from.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w500,
                          height: 1.44,
                        ),
                      ),
                      SizedBox(height: 16.h),

                      // ========== Second Instruction with Info Icon ==========
                      // Purpose: Type or speak instruction with dialog trigger
                      // Layout: Text + info icon
                      Text(
                        'Type or Speak in your waypoints separated',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w500,
                          height: 1.44,
                        ),
                      ),
                      Row(
                        crossAxisAlignment:
                            CrossAxisAlignment.center, // 🔑 important
                        children: [
                          Text(
                            'by commas.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w500,
                              height: 1.44,
                            ),
                          ),
                          SizedBox(width: 8.w),

                          // ========== Info Icon Button ==========
                          GestureDetector(
                            onTap: () {
                              showEnterDirectionsInfoDialog(context);
                            },
                            child: Center(
                              // 🔑 icon vertically center
                              child: SvgPicture.asset(
                                "assets/icons/Question-Box-gray.svg",
                                width: 20.w,
                                height: 20.h,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20.h),

                      // ========== Text Input Field with Microphone ==========
                      // Purpose: Multi-line text input for directions
                      // Design: White background, dark border-left, mic icon
                      // Height: 246 (fixed to match previous screens)
                      Container(
                        width: double.infinity,
                        height: 246,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            left: BorderSide(
                              color: Color(0xFF1A2332),
                              width: 3.w,
                            ),
                          ),
                        ),
                        child: Stack(
                          children: [
                            // ========== Text Field ==========
                            // Purpose: Enter waypoints (type or voice)
                            // Style: Multi-line, Lato font, 20sp
                            Padding(
                              padding: EdgeInsets.only(
                                left: 15.w,
                                top: 17.h,
                                right: 15.w,
                                bottom: 50.h, // Space for mic button
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
                            // Purpose: Toggle voice recording
                            // Position: Bottom-right corner
                            // Color: Red when recording, gray when not
                            Positioned(
                              bottom: 12.h,
                              right: 15.w,
                              child: Obx(
                                () => GestureDetector(
                                  onTap: () => controller.toggleRecording(),
                                  child: Container(
                                    width: 40.w,
                                    height: 40.h,
                                    decoration: BoxDecoration(
                                      color: controller.isRecording.value
                                          ? Colors.red.withOpacity(0.1)
                                          : Colors.transparent,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.mic,
                                      size: 28.sp,
                                      color: controller.isRecording.value
                                          ? Colors.red
                                          : Color(0xFF666666),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.h),

                      // ========== Bottom Action Buttons Row ==========
                      // Purpose: Navigation controls
                      // Layout: Back (left) and Continue (right)
                      Row(
                        children: [
                          // ========== Back Button ==========
                          // Width: 57, Height: 24
                          // Background: Orange
                          // Border radius: 5.r
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              width: 57,
                              height: 24,
                              decoration: BoxDecoration(
                                color: AppColors.orange,
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              child: Center(
                                child: Text(
                                  'Back',
                                  style: TextStyle(
                                    fontSize: 15.sp,
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
                          // Width: 76, Height: 24
                          // Background: Orange
                          // Border radius: 5.r
                          GestureDetector(
                            onTap: () {
                              print('Continue button tapped');
                              // TODO: Process directions and navigate
                            },
                            child: Container(
                              width: 76,
                              height: 24,
                              decoration: BoxDecoration(
                                color: AppColors.orange,
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              child: Center(
                                child: Text(
                                  'Continue',
                                  style: TextStyle(
                                    fontSize: 15.sp,
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

                      SizedBox(height: 40.h), // Bottom spacing
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
// Purpose: Show voice/type instructions
// Design: Dark gray dialog with detailed typing and speaking instructions
// Trigger: When user taps info icon (?)
void showEnterDirectionsInfoDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        // ========== Dialog Positioning ==========
        // Position: Top-center of screen
        insetPadding: EdgeInsets.only(
          top: 60.h,
          bottom: 100.h,
          left: 20.w,
          right: 20.w,
        ),
        child: Container(
          // ========== Dialog Container ==========
          // Background: Dark gray (#4A4A4A)
          // Padding: 20.w all around
          // Border radius: 12.r
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Color(0xFF4A4A4A),
            borderRadius: BorderRadius.circular(12.r),
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
                          height: 24,),
                        SizedBox(width: 12.w),
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
                SizedBox(height: 16.h),

                // ========== Dialog Content ==========
                // Purpose: Detailed instructions for entering directions
                // Font: Lato, 18sp, White, height 1.44
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
