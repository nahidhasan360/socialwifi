// Flutter pixel‑perfect UI (Static + commented dynamic GetX logic)

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:right_routes/core/routes/all_routes.dart';
import 'package:right_routes/utils/colors.dart';
import '../../../global_widget/custom_troggle_button.dart';
import '../../../utils/assets_manager.dart';
// import 'package:get/get.dart'; // controller line (commented)
// final controller = Get.put(LoginController()); // one‑line controller (commented)
import 'package:get/get.dart';

class LoginAccount extends StatelessWidget {
   LoginAccount({super.key});
  final loginTroggleController = Get.put(ToggleController());

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
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
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 21),
                  SizedBox(
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

                  SizedBox(height: 21),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// TITLE
                      SizedBox(
                        child: Text(
                          'Good News you already have a Right Route account',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.sp,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w700,
                            height: 1.12,
                          ),
                        ),
                      ),

                      SizedBox(height: 17.h),

                      /// EMAIL TEXT
                      Text(
                        'Since you’ve already used your email to sign up for this service, you can now log in using',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w500,
                          height: 1.44,
                        ),
                      ),
                      /// EMAIL
                      Row(
                        children: [
                          Text(
                            'tanvirhasan890@gmail.com', // static
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 18,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.bold,
                              height: 1.44,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.enterEmailScreen);
                            },
                            child: Text(
                              'edit',
                              style: TextStyle(
                                color: const Color(0xFF9DACF5),
                                fontSize: 18,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.bold,
                                height: 1.44,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 14),
                      SizedBox(
                        child: Text(
                          'Enter your current password to log in.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w500,
                            height: 1.56,
                          ),
                        ),
                      ),
                      SizedBox(height: 9),

                      /// PASSWORD FIELD
                      Container(
                        height: 57,
                        padding: EdgeInsets.symmetric(horizontal: 14.w),
                        decoration: BoxDecoration(
                          color: AppColors.medGray,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'password',
                                  hintStyle: TextStyle(
                                    color: const Color(0xFFBFBFBF),
                                    fontSize: 16,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w400,
                                    height: 1.75,
                                  ),
                                ),
                              ),
                            ),
                            Icon(Icons.visibility_off, color: Colors.white54),

                            // Obx(() => IconButton(
                            //   icon: Icon(controller.hidePassword.value
                            //       ? Icons.visibility_off
                            //       : Icons.visibility),
                            //   onPressed: () => controller.togglePassword(),
                            // )),
                          ],
                        ),
                      ),

                      SizedBox(height: 24.h),

                      /// ============ LOGIN BUTTON + FINGERPRINT ================
                      ///
                      ///
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoutes.otpVerificationScreen);
                              },
                              child: Container(
                                height: 50.h,
                                decoration: BoxDecoration(
                                  color: AppColors.orange,
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Center(
                                  child: Text(
                                    'LOG IN',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontFamily: "League Gothic",
                                      fontWeight: FontWeight.w600,
                                      height: 1.17,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Container(
                            height: 50.h,
                            width: 55.w,
                            decoration: BoxDecoration(
                              color: AppColors.orange,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.fingerprint,
                                color: AppColors.white,
                                size: 45.sp,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 15.h),



                      Row(
                        children: [
                          CustomToggleSwitchAdvanced(
                            height: 24,
                            width: 51,
                            value: loginTroggleController.isEnabled,
                            onChanged: (val) {
                              print('Toggle: $val');
                            },
                            activeSvgPath:
                            'assets/icons/Check-orange.svg', // SVG path
                            svgColor: AppColors.orange, // Icon color
                            activeColor: Color(0xFFFF8C42), // Track color
                            inactiveColor: Colors.white.withOpacity(
                              0.3,
                            ), // OFF color
                          ),
                          SizedBox(width: 7),
                          Text(
                            'Use touch ID',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),


                      /// TOUCH ID SWITCH

                      SizedBox(height: 45.h),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.otpVerificationScreen);
                            },
                            child: Text(
                              'Having trouble logging in? Send a one time code.',
                              style: TextStyle(
                                color: const Color(0xFF9DACF5),
                                fontSize: 16,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w500,
                                height: 1.38,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
