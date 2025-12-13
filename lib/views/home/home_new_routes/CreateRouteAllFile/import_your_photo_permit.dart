import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:right_routes/global_widgets/custom_navbar.dart';
import 'package:right_routes/utils/assets_manager.dart';
import 'package:right_routes/utils/colors.dart';

class ImportYourPhotoPermit extends StatelessWidget {
  const ImportYourPhotoPermit({super.key});

  @override
  Widget build(BuildContext context) {
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
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 22.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ========== Title with Info Icon ==========
                      Row(
                        children: [
                          Text(
                            'IMPORT A PHOTO OF YOUR PERMIT',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontFamily: 'League Gothic',
                              fontWeight: FontWeight.w400,
                              height: 0.88,
                              letterSpacing: 1.50,
                            ),
                          ),
                          SizedBox(width: 8.w),

                          // ========== Info Icon Button ==========
                          // Purpose: Trigger info dialog
                          // Action: Show import information popup
                          GestureDetector(
                            onTap: () {
                              // ✅ Show dialog when tapped
                              showImportPermitInfoDialog(context);
                            },
                            child: Container(
                              child: SvgPicture.asset(
                                "assets/icons/Question-Box-gray.svg",
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),

                      // ========== First Instruction Paragraph ==========
                      Text(
                        "Place your permit on a flat surface and use this device's camera to take a photo in vertical format. Take a photo of only one permit at a time. Be sure the permit fills the entire screen and is in focus.\nSave it then return here to Import.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 5),
                      // ========== Second Instruction Paragraph ==========
                      Text(
                        'After importing, edit as needed or import your next permit image before tapping Continue.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w500,
                          height: 1.44,
                        ),
                      ),
                      SizedBox(height: 24.h),

                      // ========== Import Button ==========
                      GestureDetector(
                        onTap: () {
                          print('Import button tapped');
                        },
                        child: Container(
                          width: 64,
                          height: 24,
                          // padding: EdgeInsets.symmetric(
                          //   horizontal: 24.w,
                          //   vertical: 12.h,
                          // ),
                          decoration: BoxDecoration(
                            color: AppColors.orange,
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Center(
                            child: Text(
                              'Import',
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
                      SizedBox(height: 15.h),

                      // ========== Extracted Directions Card ==========
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
                        padding: EdgeInsets.only(
                          left: 15.w,
                          top: 17.h,
                          bottom: 12.h,
                          right: 16.w,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'I-29 S',
                              style: TextStyle(
                                color: const Color(0xFF141414),
                                fontSize: 20,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w500,
                                height: 1.40,
                              ),
                            ),
                            Text(
                              'Exit 63A-B',
                              style: TextStyle(
                                color: const Color(0xFF141414),
                                fontSize: 20,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w500,
                                height: 1.40,
                              ),
                            ),
                            Text(
                              'Exit 63B',
                              style: TextStyle(
                                color: const Color(0xFF141414),
                                fontSize: 20,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w500,
                                height: 1.40,
                              ),
                            ),
                            Text(
                              'I-94 W',
                              style: TextStyle(
                                color: const Color(0xFF141414),
                                fontSize: 20,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w500,
                                height: 1.40,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.h),

                      // ========== Bottom Action Buttons Row ==========
                      Row(
                        children: [
                          // Back Button
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              width: 57,
                              height: 24,
                              // padding: EdgeInsets.symmetric(
                              //   horizontal: 28.w,
                              //   vertical: 14.h,
                              // ),
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

                          // Continue Button
                          GestureDetector(
                            onTap: () {
                              print('Continue button tapped');
                            },
                            child: Container(
                              width: 76,
                              height: 24,
                              decoration: BoxDecoration(
                                color: AppColors.orange,
                                borderRadius: BorderRadius.circular(8.r),
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

                      SizedBox(height: 40.h),
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
// Paste the dialog function here or in a separate file
void showImportPermitInfoDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.only(bottom: 305.h, left: 20.w, right: 20.w),
        child: Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Color(0xFF4A4A4A),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    "assets/icons/Import_white.svg",
                    width: 23,
                    height: 23,
                    color: Colors.white,
                  ),
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
              Text(
                "To import the image of your permit, tap Import then navigate to your device's photo library, select the image and tap the button to import it into this app.\nThis app will automatically extract the directions from the image which will appear in the field below.",
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
      );
    },
  );
}
