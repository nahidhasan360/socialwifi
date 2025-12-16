import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:right_routes/core/routes/all_routes.dart';

import '../../../utils/assets_manager.dart';
import '../../../utils/colors.dart';

class OtpVerificationScreen extends StatelessWidget {
  final controller = Get.put(OtpVerificationController());

  OtpVerificationScreen({super.key});

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
          padding: EdgeInsets.all(22),
          child: SingleChildScrollView(

            child: Column(
              children: [
                const SizedBox(height: 40),

                /// LOGO
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

                SizedBox(height: 19.h),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// TITLE
                    Text(
                      "Check your email inbox",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w700,
                        height: 1.12,
                      ),
                    ),


                    SizedBox(height: 19.h),
                    SizedBox(
                      width: 385,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'We’ll need you to verify your email address. We’ve sent a 6-digit code to ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w500,
                                height: 1.44,
                              ),
                            ),
                            TextSpan(
                              text: 'tanvirhasancr8****@gmail.com',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w900,
                                height: 1.44,
                              ),
                            ),
                            TextSpan(
                              text: ' ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w700,
                                height: 1.44,
                              ),
                            ),
                            TextSpan(
                              text: 'The code expires in 15 minutes. Please enter it below.',
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

                    SizedBox(height: 25.h),

                    /// PIN CODE FIELD
                    PinCodeTextField(
                      length: 6,
                      appContext: context,
                      animationType: AnimationType.fade,

                      keyboardType: TextInputType.number,
                      obscureText: false,
                      cursorColor: Colors.black,

                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5.r),
                        fieldHeight: 49.h,
                        fieldWidth: 49.w,
                        inactiveColor: Colors.transparent,
                        selectedColor: AppColors.orange,
                        activeColor: Colors.white,
                        inactiveFillColor: AppColors.medGray,
                        activeFillColor: Colors.white.withValues(alpha: 0.85),
                        selectedFillColor: Colors.white,
                      ),
                      enableActiveFill: true,
                      onChanged: (value) {},

                      // Dynamic GetX logic (commented out)
                      // onCompleted: (value) {
                      //   controller.otp.value = value;
                      //   controller.verifyOtp();
                      // },
                    ),

                    SizedBox(height: 25.h),

                    /// CONTINUE BUTTON
                    GestureDetector(
                      onTap: () {
                        // controller.verifyOtp();
                        Get.toNamed(AppRoutes.weLoggedYou);
                      },
                      child: Container(
                        width: 392,
                        height: 55,
                        decoration: BoxDecoration(
                          color: AppColors.orange,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'CONTINUE',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'League Gothic',
                            fontWeight: FontWeight.w400,
                            height: 1.17,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 25.h),

                    GestureDetector(
                      onTap: () {
                        Get.back();

                      },
                      child: Container(
                        width: 392,
                        height: 55,
                        decoration: BoxDecoration(
                          color: AppColors.medGray,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'CANCEL',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'League Gothic',
                            fontWeight: FontWeight.w400,
                            height: 1.17,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 48.h),

                    /// RESEND
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Didn’t receive the mail? Check your spam folder or",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w500,
                            height: 1.38,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRoutes.otpVerificationScreen);
                          },
                          child: Text(
                            "Resend",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: const Color(0xFF9DACF5),
                              fontSize: 16,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w500,
                              height: 1.38,
                              decoration: TextDecoration.underline,
                            ),

                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 40.h),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OtpVerificationController extends GetxController {
  // var otp = ''.obs;

  // void verifyOtp() {}
  // void resendOtp() {}
}
