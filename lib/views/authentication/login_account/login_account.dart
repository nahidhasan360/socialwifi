import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:right_routes/core/routes/all_routes.dart';
import 'package:right_routes/utils/colors.dart';
import 'package:right_routes/views/authentication/login_account/reusable_enter_email-screen.dart';
import '../../../global_widget/custom_troggle_button.dart';
import '../../../utils/assets_manager.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'login-controller.dart';

// ============================================================================
// SCREEN
// ============================================================================
class LoginAccount extends StatelessWidget {
  LoginAccount({super.key});

  final loginTroggleController = Get.put(ToggleController());
  final controller = Get.put(LoginController());

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
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 21),

                // Logo
                Container(
                  width: 225,
                  height: 112,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(ImageManager.splashScreenLogo),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SizedBox(height: 21),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// TITLE
                    Text(
                      'Good News you already have a Right Route account',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w700,
                        height: 1.12,
                      ),
                    ),

                    SizedBox(height: 17),

                    /// EMAIL TEXT
                    Text(
                      'Since you\'ve already used your email to sign up for this service, you can now log in using',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w500,
                        height: 1.44,
                      ),
                    ),

                    /// EMAIL
                    /// EMAIL - ডাইনামিক + edit অপশন
                    Obx(() {
                      final String email = controller.userEmail.value.trim();

                      final String displayEmail = email.isEmpty
                          ? 'Your email...'
                          : email;

                      return Row(
                        children: [
                          Text(
                            displayEmail,
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 18,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.bold,
                              height: 1.44,
                            ),
                          ),
                          SizedBox(width: 4),
                          GestureDetector(
                            onTap: () {
                              Get.to(
                                () => ReusableEnterEmailScreen(
                                  title: 'Enter your email to continue',
                                  subtitle: 'Log in to your Route Route account. If you don’t have one, you will be prompted to create one.',
                                  buttonText: 'CONTINUE',
                                  onContinue: () {
                                    Get.back();
                                  },

                                  onEmailSubmitted: (newEmail) {
                                    controller.setEmail(newEmail); //
                                  },
                                ),
                              );
                            },
                            child: Text(
                              'edit',
                              style: TextStyle(
                                color: AppColors.purple,
                                fontSize: 18,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.bold,
                                height: 1.44,
                              ),
                            ),
                          ),
                        ],
                      );
                    }),

                    SizedBox(height: 14),

                    Text(
                      'Enter your current password to log in.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w500,
                        height: 1.56,
                      ),
                    ),

                    SizedBox(height: 9),

                    /// PASSWORD FIELD
                    Container(
                      height: 57,
                      padding: EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: AppColors.medGray,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Obx(
                              () => TextField(
                                obscureText: controller.hidePassword.value,
                                style: TextStyle(color: Colors.white),
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
                          ),
                          Obx(
                            () => IconButton(
                              icon: Icon(
                                controller.hidePassword.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.white54,
                              ),
                              onPressed: () => controller.togglePassword(),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24),

                    /// ============ LOGIN BUTTON + FINGERPRINT ================
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.homeNewRoutes);
                            },
                            child: Container(
                              height: 50,
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
                        SizedBox(width: 10),

                        /// ✅ FINGERPRINT BUTTON - FULLY FUNCTIONAL WITH ANIMATIONS
                        Obx(
                          () => GestureDetector(
                            onTap: () async {
                              print('\n👆 Fingerprint button pressed!');
                              // Trigger biometric authentication
                              await controller.authenticateWithBiometrics();
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 150),
                              height: 50,
                              width: 55,
                              decoration: BoxDecoration(
                                color: controller.availableBiometrics.isEmpty
                                    ? AppColors.orange
                                    : AppColors.orange,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.fingerprint,
                                  color: AppColors.white,
                                  size: 45,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 15),

                    /// ✅ TOUCH ID SWITCH
                    Row(
                      children: [
                        CustomToggleSwitchAdvanced(
                          height: 24,
                          width: 51,
                          value: loginTroggleController.isEnabled,
                          onChanged: (val) {
                            controller.toggleTouchID(val);
                          },
                          activeSvgPath: 'assets/icons/Check-orange.svg',
                          svgColor: AppColors.orange,
                          activeColor: AppColors.orange,
                          inactiveColor: Colors.white.withOpacity(0.3),
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

                    SizedBox(height: 45),

                    /// TROUBLE LOGGING IN
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.otpVerificationScreenlogin);
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

                    SizedBox(height: 20),
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
