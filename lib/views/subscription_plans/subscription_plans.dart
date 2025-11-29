import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:right_routes/core/routes/all_routes.dart';
import 'package:right_routes/global_widgets/custom_buttons.dart';
import '../../../utils/assets_manager.dart';
import '../../global_widgets/button_reusable.dart';

class ChoosePlanScreen extends StatelessWidget {
  const ChoosePlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final planController = Get.put(PlanController());

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
        child: Column(
          children: [
            SizedBox(height: 85),

            /// Logo
            Container(
              width: 225,
              height: 112,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImageManager.splashScreenLogo),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 24.h),

            /// Title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                'INDIVIDUAL OR TEAM?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontFamily: 'League Gothic',
                  fontWeight: FontWeight.w400,
                  height: 0.88,
                  letterSpacing: 1,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),

            /// Subtitle
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                'Choose an option to start your 7-day free trial\nand begin automating your routes. Cancel\nanytime.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w500,
                  height: 1.56,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 32.h),

            /// Individual Button
            ButtonReusable(
              text: "INDIVIDUAL",
              width: 249.w,
              height: 54.h,
              fontSize: 24,
              onPressed: () {
                // planController.selectIndividual();
                Get.toNamed(AppRoutes.enterEmailScreen);
              },
            ),
            SizedBox(height: 16.h),

            /// Team Button
            ButtonReusable(
              text: "TEAM",
              width: 250.w,
              height: 55.h,
              fontSize: 24,
              onPressed: () {
                // planController.selectIndividual();
                Get.toNamed(AppRoutes.enterEmailScreen);
              },
            ),
            Spacer(),

            /// Restore Subscription
            TextButton(
              onPressed: () {
                // planController.restoreSubscription();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Already a subscriber?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w500,
                      height: 1.75,
                    ),
                  ),
                  Text(
                    'RESTORE SUBSCRIPTION',
                    style: TextStyle(
                      color: const Color(0xFF9DACF5),
                      fontSize: 19.sp,
                      fontFamily: 'League Gothic',
                      fontWeight: FontWeight.w400,
                      height: 1.40,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 49.h),
          ],
        ),
      ),
    );
  }
}
