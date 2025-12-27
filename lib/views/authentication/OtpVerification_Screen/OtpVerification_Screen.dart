import 'package:flutter/gestures.dart';
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
          padding: EdgeInsets.symmetric(horizontal: 20),
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

                    SizedBox(height: 21),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text:
                                'We’ll need you to verify your email address.We’ve sent a 6-digit code to ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: 'tanvirhasancr8****@gmail.com',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.bold,
                              height: 1.44,
                            ),
                          ),

                          TextSpan(
                            text:
                                'The code expires in 15 minutes. Please enter it below.',
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

                    SizedBox(height: 28),

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
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 50,
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

                    SizedBox(height: 18),

                    /// CONTINUE BUTTON
                    GestureDetector(
                      onTap: () {
                        // controller.verifyOtp();
                        Get.toNamed(AppRoutes.weLoggedYou);
                      },
                      child: Container(
                        width: double.infinity,
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

                    SizedBox(height: 29),

                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        width: double.infinity,
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
                    SizedBox(height: 53),

                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Didn’t receive the mail? Check your spam folder or ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15, // white text = purple text same size
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w500,
                              height: 1.38,
                            ),
                          ),
                          TextSpan(
                            text: "Resend",
                            style: TextStyle(
                              color: AppColors.purple,
                              fontSize: 16,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w500,
                              height: 1.38,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.toNamed(AppRoutes.otpVerificationScreen);
                              },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
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
