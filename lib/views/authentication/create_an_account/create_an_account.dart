// create_an_account.dart
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:right_routes/core/routes/all_routes.dart';
import 'package:right_routes/utils/colors.dart';
import '../../../global_widget/custom_troggle_button.dart';
import '../../../utils/assets_manager.dart';
import '../terms_of_service/terms_of_service.dart';
import 'create_password_controller.dart';

class CreateAnAccount extends StatelessWidget {
  CreateAnAccount({super.key});

  final controller = Get.put(CreatePasswordController());
  final troggleController = Get.put(ToggleController());

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
              SizedBox(height: 40),

              /// ================= Sticky Logo ================
              Center(child: _buildLogo()),
              SizedBox(height: 20),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Main Title
                        Text(
                          'Create an account to continue',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                            height: 1.12,
                          ),
                        ),

                        SizedBox(height: 18),

                        /// Subtitle
                        Text(
                          'Creating an account gives you full functionality, '
                          'access to your route history, account settings and subscription status.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w500,
                            height: 1.44,
                          ),
                        ),

                        SizedBox(height: 17),

                        /// Email Display
                        _buildEmailDisplay(),
                        SizedBox(height: 32),

                        /// Password Field
                        _buildPasswordField(screenWidth),

                        /// progress bar
                        _buildProgressBar(),

                        /// Password Rules
                        Obx(
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _ruleTile(
                                controller.isSixChars.value,
                                "Use a minimum of six characters ( Case sensitive )",
                              ),
                              SizedBox(height: 12),
                              _ruleTile(
                                controller.hasNumberOrSpecial.value,
                                "Use letters with at least one number or special character",
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 18),

                        // /// Touch ID Switch (WORKING)
                        // Obx(
                        //       () => Row(
                        //     crossAxisAlignment: CrossAxisAlignment.center,
                        //     children: [
                        //       Transform.scale(
                        //         scaleX: 0.87,
                        //         scaleY: 0.77,
                        //         child: Stack(
                        //           alignment: Alignment.center,
                        //           children: [
                        //             Switch(
                        //               value: controller.useTouchId.value,
                        //               onChanged: (v) => controller.useTouchId.value = v,
                        //
                        //               activeTrackColor: AppColors.orange,
                        //               inactiveTrackColor: Colors.white.withOpacity(0.3),
                        //               activeThumbColor: Colors.white,
                        //               inactiveThumbColor: Colors.white,
                        //             ),
                        //
                        //             /// ✅ SVG check icon on thumb
                        //             Positioned(
                        //               left: controller.useTouchId.value ? 28 : 6, // thumb position
                        //               child: controller.useTouchId.value
                        //                   ? SvgPicture.asset(
                        //                 "assets/icons/Check-orange.svg",
                        //                 width: 12,
                        //                 height: 12,
                        //                 colorFilter: const ColorFilter.mode(
                        //                   AppColors.orange,
                        //                   BlendMode.srcIn,
                        //                 ),
                        //               )
                        //                   : const SizedBox(),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //
                        //       const SizedBox(width: 5),
                        //
                        //       const Text(
                        //         "Use touch ID",
                        //         style: TextStyle(
                        //           color: Colors.white,
                        //           fontSize: 14,
                        //           fontFamily: 'Lato',
                        //           fontWeight: FontWeight.w500,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        //
                        Row(
                          children: [
                            CustomToggleSwitchAdvanced(
                              height: 24,
                              width: 51,
                              value: troggleController.isEnabled,
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

                        //
                        // /// Touch ID Switch
                        //   Obx(
                        //         () => Row(
                        //       crossAxisAlignment: CrossAxisAlignment.center,
                        //       children: [
                        //         // Switch with clean thumb (no icon needed based on images)
                        //         Transform.scale(
                        //           scaleX: 0.87,
                        //           scaleY: 0.77,
                        //           child: Switch(
                        //             padding: EdgeInsets.only(left: -6),
                        //             value: controller.useTouchId.value,
                        //
                        //             // Colors matching your images
                        //             activeThumbColor: AppColors.white,      // Orange thumb when ON
                        //             activeTrackColor: AppColors.orange,  // Light orange track
                        //             inactiveThumbColor: Colors.white,         // White thumb when OFF
                        //             inactiveTrackColor: Colors.white.withOpacity(0.3),    // Light white track
                        //
                        //             // No thumbIcon needed - images show clean thumb
                        //             // If you want icon, uncomment below:
                        //
                        //             thumbIcon: WidgetStateProperty.resolveWith<Icon?>((states) {
                        //               if (states.contains(WidgetState.selected)) {
                        //                 return ;
                        //               }
                        //               return null;
                        //             }),
                        //
                        //
                        //             onChanged: (v) => controller.useTouchId.value = v,
                        //           ),
                        //         ),
                        //         SizedBox(width: 5),
                        //
                        //         Text(
                        //           "Use touch ID",
                        //           style: TextStyle(
                        //             color: Colors.white,
                        //             fontSize: 14,
                        //             fontFamily: 'Lato',
                        //             fontWeight: FontWeight.w500,
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        SizedBox(height: 21),

                        /// Terms Checkbox
                        Obx(() => _buildTermsCheckbox()),

                        SizedBox(height: 12),

                        /// Privacy Checkbox
                        Obx(() => _buildPrivacyCheckbox()),

                        SizedBox(height: 28),

                        /// Continue Button
                        Obx(() => _buildContinueButton()),

                        SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ================= Logo ======================
  Widget _buildLogo() {
    return Container(
      width: 225,
      height: 112,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageManager.splashScreenLogo),
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  /// ================= Dynamic Progress Bar ======================
  Widget _buildProgressBar() {
    return Obx(() {
      final progress = controller.strengthProgress.value;
      final color = controller.strengthColor.value;
      final label = controller.strengthLabel.value;

      return Padding(
        padding: EdgeInsets.only(top: 7, bottom: 15, left: 0, right: 70),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 8,
                decoration: BoxDecoration(
                  color: AppColors.medGray,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  children: [
                    AnimatedFractionallySizedBox(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      alignment: Alignment.centerLeft,
                      widthFactor: progress,
                      child: Container(
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(width: 12),

            SizedBox(
              width: 60,
              child: AnimatedDefaultTextStyle(
                duration: Duration(milliseconds: 300),
                style: TextStyle(
                  color: color,
                  fontSize: 16,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w600,
                ),
                child: Text(label, textAlign: TextAlign.left),
              ),
            ),
          ],
        ),
      );
    });
  }

  /// ================= Email Display ======================
  Widget _buildEmailDisplay() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Create your account using',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w400,
            height: 1.44,
          ),
        ),
        Row(
          children: [
            Obx(
              () => Text(
                controller.email.value,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  height: 1.44,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            SizedBox(width: 8),
            GestureDetector(
              onTap: controller.editEmail,
              child: GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.enterEmailScreen);
                },
                child: Text(
                  'edit',
                  style: TextStyle(
                    color: AppColors.editEmailColor,
                    fontSize: 18,
                    height: 1.44,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                    decorationColor: Color(0xFF5B9BFF),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// ================= Password Field ======================
  Widget _buildPasswordField(double screenWidth) {
    return Obx(
      () => Container(
        width: 388,
        height: 48,
        decoration: ShapeDecoration(
          color: AppColors.medGray,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          children: [
            SizedBox(width: 16),
            Expanded(
              child: TextField(
                controller: controller.passwordController,
                obscureText: controller.isPasswordHidden.value,
                onChanged: (v) => controller.password.value = v,
                // 🔥 Cursor style here
                cursorColor: Colors.white,
                cursorWidth: 2,
                cursorHeight: 20,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Lato',
                ),
                decoration: InputDecoration(
                  hintText: "Create a password",
                  hintStyle: TextStyle(
                    color: Color(0xffBFBFBF),
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    fontFamily: 'Lato',
                    height: 1.75,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            GestureDetector(
              onTap: controller.togglePasswordVisibility,
              child: Padding(
                padding: EdgeInsets.only(right: 16),
                child: Icon(
                  controller.isPasswordHidden.value
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Colors.white.withValues(alpha: 0.6),
                  size: 22,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ================= Rule Tile ============================
  Widget _ruleTile(bool active, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 20,
          height: 20,
          // margin: EdgeInsets.only(top: 2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: active ? AppColors.orange : AppColors.medGray,
            border: Border.all(
              color: active ? AppColors.orange : AppColors.medGray,
              width: 2,
            ),
          ),
          child: active
              ? Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 12,
                  fontWeight: FontWeight.bold,
                )
              : null,
        ),
        SizedBox(width: 7),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Lato',
              height: 1.25,
            ),
          ),
        ),
      ],
    );
  }

  /// ================= Terms Checkbox =====================
  Widget _buildTermsCheckbox() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCustomCheckbox(
          controller.agreeTerms.value,
          () => controller.agreeTerms.value = !controller.agreeTerms.value,
        ),
        SizedBox(width: 7),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "I have read & agree to the ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Lato',
                    height: 1.38,
                  ),
                ),
                TextSpan(
                  text: "Terms of Use",
                  style: TextStyle(
                    color: AppColors.purple,
                    fontSize: 16,
                    fontFamily: 'Lato',
                    height: 1.38,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = controller.viewTermsOfUse,
                ),
                TextSpan(
                  text: ".",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// ================= Privacy Checkbox =====================
  Widget _buildPrivacyCheckbox() {
    return Container(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCustomCheckbox(
            controller.agreePrivacy.value,
            () =>
                controller.agreePrivacy.value = !controller.agreePrivacy.value,
          ),
          SizedBox(width: 7),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "I have read & understand the ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Lato',
                      height: 1.38,
                    ),
                  ),
                  TextSpan(
                    text: "Privacy & Policy",
                    style: TextStyle(
                      color: AppColors.purple,
                      fontSize: 16,
                      fontFamily: 'Lato',
                      height: 1.38,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = controller.viewPrivacyPolicy,
                  ),
                  TextSpan(
                    text:
                        ", and understand the nature of my consent to the collection, use and/or disclosure of my personal data and the consequences of such consent.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Lato',
                      height: 1.38,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ================= Custom Checkbox =====================
  /// ================= Custom Checkbox with SVG Icon =====================
  Widget _buildCustomCheckbox(bool value, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 24,
        height: 24,
        margin: EdgeInsets.only(top: 2),
        decoration: BoxDecoration(
          color: value ? AppColors.orange : AppColors.medGray,
          border: Border.all(
            color: value ? AppColors.orange : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(3),
        ),
        child: value
            ? SvgPicture.asset(
                "assets/icons/Check-Box-orange.svg",
                width: 12,
                height: 12,
              )
            : null,
      ),
    );
  }

  /// ================= Continue Button =====================
  Widget _buildContinueButton() {
    final isEnabled = controller.isFormValid;

    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.loginAccount);
      },
      child: Container(
        width: 393,
        height: 55,
        decoration: BoxDecoration(
          gradient: isEnabled
              ? LinearGradient(colors: [Color(0xffF58842), Color(0xffF58842)])
              : null,
          color: isEnabled ? null : AppColors.orange,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            'AGREE & CONTINUE',
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
    );
  }
}
