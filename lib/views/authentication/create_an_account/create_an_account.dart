// create_an_account.dart
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:right_routes/core/routes/all_routes.dart';
import 'package:right_routes/utils/colors.dart';
import '../../../utils/assets_manager.dart';
import '../terms_of_service/terms_of_service.dart';
import 'create_password_controller.dart';

class CreateAnAccount extends StatelessWidget {
  CreateAnAccount({super.key});

  final controller = Get.put(CreatePasswordController());

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

        child: Column(
          children: [
            SizedBox(height: 40),
            /// ================= Sticky Logo ================
            Center(child: _buildLogo()),

            Expanded(
              child: Padding(
                padding: EdgeInsets.all(23),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Main Title
                      SizedBox(
                        width: 379.w,
                        child: Text(
                          'Create an account to continue',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w700,
                            height: 1.12,
                          ),
                        ),
                      ),

                      SizedBox(height: 18.h),

                      /// Subtitle
                      Text(
                        'Creating an account gives you full functionality, '
                        'access to your route history, account settings and subscription status.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w400,
                          height: 1.44,
                        ),
                      ),

                      SizedBox(height: 17.h),

                      /// Email Display
                      _buildEmailDisplay(),
                      SizedBox(height: 32.h),

                      /// Password Field
                      _buildPasswordField(),

                      SizedBox(height: 12.h),

                      /// progress bar
                      _buildProgressBar(),

                      SizedBox(height: 16.h),

                      /// Password Rules
                      Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _ruleTile(
                              controller.isSixChars.value,
                              "Use a minimum of six characters ( Case sensitive )",
                            ),
                            SizedBox(height: 12.h),
                            _ruleTile(
                              controller.hasNumberOrSpecial.value,
                              "Use letters with at least one number or special character",
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 18),

                      /// Touch ID Switch
                      Obx(
                        () => Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // 👉 Switch বামে
                            Transform.scale(
                              scaleX: 0.87,
                              scaleY: 0.77,
                              child: Switch(
                                padding: EdgeInsets.only(left: -6),
                                value: controller.useTouchId.value,
                                activeThumbColor: AppColors.orange,
                                activeTrackColor: AppColors.orange
                                    .withOpacity(0.5),
                                inactiveThumbColor: Colors.grey,
                                inactiveTrackColor: Colors.grey.withOpacity(
                                  0.3,
                                ),
                                onChanged: (v) =>
                                    controller.useTouchId.value = v,
                              ),
                            ),
                            SizedBox(width: 5.w),

                            // 👉 Text ডানে
                            Text(
                              "Use touch ID",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 21.h),

                      /// Terms Checkbox
                      Obx(() => _buildTermsCheckbox()),

                      SizedBox(height: 12.h),

                      /// Privacy Checkbox
                      Obx(() => _buildPrivacyCheckbox()),

                      SizedBox(height: 37),

                      /// Continue Button
                      Obx(() => _buildContinueButton()),

                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
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
      final progress = controller.strengthProgress.value; // Will be 0.7
      final color = controller.strengthColor.value; // Will be Colors.orange
      final label = controller.strengthLabel.value; // Will be "Fair"

      return Padding(
        // ... (rest of your widget code remains unchanged)
        padding: EdgeInsets.only(top: 15, bottom: 15, left: 0, right: 70),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 8.h,
                decoration: BoxDecoration(
                  color: Color(0xFF4A4A4A),
                  borderRadius: BorderRadius.circular(10.r),
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
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(width: 12.w),

            SizedBox(
              width: 60.w,
              child: AnimatedDefaultTextStyle(
                duration: Duration(milliseconds: 300),
                style: TextStyle(
                  color: color,
                  fontSize: 16.sp,
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
              child: Text(
                'edit',
                style: TextStyle(
                  color: Color(0xFF5B9BFF),
                  fontSize: 18,
                  height: 1.44,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                  decorationColor: Color(0xFF5B9BFF),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// ================= Password Field ======================
  Widget _buildPasswordField() {
    return Obx(
      () => Container(
        width: 388,
        height: 48,
        decoration: ShapeDecoration(
          color: AppColors.medGray,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        child: Row(
          children: [
            SizedBox(width: 16.w),
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
                padding: EdgeInsets.only(right: 16.w),
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
          width: 18.w,
          height: 18.w,
          margin: EdgeInsets.only(top: 2.h),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: active ? AppColors.orange : Colors.transparent,
            border: Border.all(
              color: active ? AppColors.orange : Colors.white.withOpacity(0.5),
              width: 2,
            ),
          ),
          child: active
              ? Icon(Icons.check, color: Colors.white, size: 3.sp)
              : null,
        ),
        SizedBox(width: 7.w),
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
        SizedBox(width: 7.w),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "I have read & agree to the ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Lato',
                    height: 1.38,
                  ),
                ),
                TextSpan(
                  text: "Terms of Use",
                  style: TextStyle(
                    color: Color(0xFF5B9BFF),
                    fontSize: 15,
                    fontFamily: 'Lato',
                    height: 1.38,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = controller.viewTermsOfUse,
                ),
                TextSpan(
                  text: ".",
                  style: TextStyle(color: Colors.white, fontSize: 12.sp),
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
            () => controller.agreePrivacy.value = !controller.agreePrivacy.value,
          ),
          SizedBox(width: 7.w),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "I have read & understand the ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'Lato',
                      height: 1.38,
                    ),
                  ),
                  TextSpan(
                    text: "Privacy & Policy",
                    style: TextStyle(
                      color: Color(0xFF5B9BFF),
                      fontSize: 15,
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
                      fontSize: 15,
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
  Widget _buildCustomCheckbox(bool value, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 24,
        height: 24,
        margin: EdgeInsets.only(top: 2.h),
        decoration: BoxDecoration(
          color: value ? AppColors.orange : AppColors.medGray,
          border: Border.all(
            color: value ? AppColors.orange : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(3.r),
        ),
        child: value
            ? Icon(Icons.check, color: Colors.white, size: 12.sp)
            : null,
      ),
    );
  }

  // ================= Continue Button =====================
  // Widget _buildContinueButton() {
  //   final isEnabled = controller.isFormValid;
  //   // ===================== routes to another screen ==================
  //   return GestureDetector(
  //     onTap: () {
  //       Get.toNamed(AppRoutes.loginAccount);
  //       print('Its clicked');
  //     },
  //
  //     // onTap: isEnabled ? controller.createAccount : null,
  //     child: Container(
  //       width: 393.w,
  //       height: 55.h,
  //       // width: double.infinity,
  //       // height: 52.h,
  //       decoration: BoxDecoration(
  //         gradient: isEnabled
  //             ? LinearGradient(colors: [Color(0xFFFF6B35), Color(0xFFFF8C42)])
  //             : null,
  //         color: isEnabled ? null : Color(0xFF4A4A6B),
  //         borderRadius: BorderRadius.circular(10.r),
  //       ),
  //       child: Center(
  //         child: Text(
  //           'AGREE & CONTINUE',
  //           style: TextStyle(
  //             color: Colors.white,
  //             fontSize: 24,
  //             fontFamily: 'League Gothic',
  //             fontWeight: FontWeight.w400,
  //             height: 1.17,
  //             letterSpacing: 2,
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildContinueButton() {
    final isEnabled = controller.isFormValid;

    return GestureDetector(
      // onTap: isEnabled
      //     ? () {
      //   Get.toNamed(AppRoutes.loginAccount);
      //   print('It\'s clicked');
      // }
      //     : null, //
      //
      //     Disable the tap if isEnabled is false
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
          borderRadius: BorderRadius.circular(10.r),
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
