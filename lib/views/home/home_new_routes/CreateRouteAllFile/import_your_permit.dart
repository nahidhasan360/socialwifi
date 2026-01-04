import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:right_routes/core/routes/all_routes.dart';
import 'package:right_routes/global_widgets/custom_navbar.dart';
import 'package:right_routes/utils/assets_manager.dart';
import 'package:right_routes/utils/colors.dart';

class ImportYourPermit extends StatelessWidget {
  const ImportYourPermit({super.key});

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
              SizedBox(height: 20), //  Added spacing

              // ========== Fixed Logo Section ==========
              Center(
                child: Container(
                  width: 225,
                  height: 112,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(ImageManager.splashScreenLogo),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 29),

              // ========== Scrollable Content Section ==========
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    left: 19,
                    right: 19,
                    bottom: 20, // ✅ Added bottom padding for navbar clearance
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // ========== Title with Info Icon ==========
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'IMPORT YOUR PERMIT',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontFamily: 'League Gothic',
                              fontWeight: FontWeight.w400,
                              height: 0.88,
                            ),
                          ),
                          SizedBox(width: 4),

                          // ========== Info Icon Button ==========
                          GestureDetector(
                            onTap: () {
                              showImportPermitInfoDialog(context);
                            },
                            child: SvgPicture.asset(
                              "assets/icons/Question-Box-gray.svg",
                              width: 18,
                              height: 18,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      // ========== First Instruction Paragraph ==========
                      Text(
                        'Tap the Import button and select your permit from whatever storage location it is sitting in.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w500,
                          height: 1.44,
                        ),
                      ),
                      Text(
                        'When selected, tap Open to start the extraction. It will take a few seconds for your directions to appear below.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w500,
                          height: 1.44,
                        ),
                      ),

                      // ========== Second Instruction Paragraph ==========
                      Text(
                        'Edit as needed or import another permit before tapping Continue.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 22),

                      // ========== Import Button ==========
                      GestureDetector(
                        onTap: () {
                          print('Import button tapped');
                        },
                        child: Container(
                          width: 67,
                          height: 24,
                          decoration: BoxDecoration(
                            color: AppColors.orange,
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Center(
                            child: Text(
                              'Import',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),

                      // ========== Extracted Directions Card ==========
                      Container(
                        width: double.infinity,
                        constraints: BoxConstraints(
                          minHeight: 246, // ✅ Changed to minHeight for flexibility
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            left: BorderSide(
                              color: Color(0xFF1A2332),
                              width: 3,
                            ),
                          ),
                        ),
                        padding: EdgeInsets.only(
                          left: 15,
                          top: 17,
                          bottom: 12,
                          right: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min, // ✅ Added
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
                      SizedBox(height: 13),

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
                              decoration: BoxDecoration(
                                color: AppColors.orange,
                                borderRadius: BorderRadius.circular(5.r),
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

                          // Continue Button
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.editConfirmStartYourRoute);
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
void showImportPermitInfoDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          width: MediaQuery.of(context).size.width,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.6,
          ),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.medGray,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/Import_white.svg",
                      width: 29,
                      height: 29,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: SvgPicture.asset(
                        "assets/icons/Close-X-Circle.svg",
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'To use this option, your permit must be imported from your device storage or online storage such as iCloud, Google Drive or DropBox. The permit cannot be imported directly from your email attachment.\n\nYou can import multiple permits one at at time. Each permit must be processed and directions appear in the editing text field before importing the next.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
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