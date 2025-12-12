
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:right_routes/core/routes/all_routes.dart';
import 'package:right_routes/global_widgets/button_reusable.dart';
import 'package:right_routes/global_widgets/custom_navbar.dart';
import 'package:right_routes/utils/colors.dart';
import 'package:right_routes/views/authentication/login_account/login_account.dart';

import '../../../utils/assets_manager.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({super.key});

  final changePassController = Get.put(
    ChangePasswordController(),
  );

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
        child: Padding(
          padding: EdgeInsets.all(22.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 40),

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
                SizedBox(height: 39.h),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Change Password',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w700,
                        height: 1,
                        letterSpacing: 1,
                      ),
                    ),
                    Divider(color: AppColors.white, thickness: 1),
                    SizedBox(height: 12),
                    Text(
                      'This replaces the password you use to log in to this app account.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w500,
                        height: 1.44,
                      ),
                    ),
                    SizedBox(height: 27),

                    // Password Input section
                    _buildPasswordField(),

                    SizedBox(height: 20.h),

                    // Password strength bar section (Animated)
                    _buildProgressBar(),

                    SizedBox(height: 20.h),

                    // Password criteria section with validation
                    Obx(
                          () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _ruleTile(
                            changePassController.isSixChars.value,
                            "Use a minimum of six characters (Case sensitive)",
                          ),
                          SizedBox(height: 12.h),
                          _ruleTile(
                            changePassController.hasNumberOrSpecial.value,
                            "Use letters with at least one number or special character",
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 28.h),



                    ButtonReusable(
                      onPressed: () => AppRoutes.emailSaved,
                      text: 'SAVE & CONTINUE',
                      width: 500.w,
                    ),
                    SizedBox(height: 19.h),
                    ButtonReusable(
                      onPressed: () => '',
                      text: 'CANCEL',
                      width: 500.w,
                      fontSize: 24,
                      backgroundColor: AppColors.medGray,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomNavbar(),
    );
  }

  /// ================= Dynamic Progress Bar ======================
  Widget _buildProgressBar() {
    return Obx(() {
      final progress = changePassController.strengthProgress.value;
      final color = changePassController.strengthColor.value;
      final label = changePassController.strengthLabel.value;

      return Padding(
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
                      alignment: Alignment.centerRight,
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
                controller: changePassController.changeEditing,
                obscureText: changePassController.isPasswordHidden.value,
                onChanged: (v) => changePassController.password.value = v,
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
              onTap: changePassController.togglePasswordVisibility,
              child: Padding(
                padding: EdgeInsets.only(right: 16.w),
                child: Icon(
                  changePassController.isPasswordHidden.value
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
          width: 19.w,
          height: 19.w,
          margin: EdgeInsets.only(top: 2.h),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: active ? AppColors.orange : AppColors.medGray,
            border: Border.all(
              color: active ? AppColors.orange : AppColors.medGray,
              width: 2,
            ),
          ),
          child: active
              ? Icon(Icons.check, color: Colors.white, size: 12.sp)
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
}

class ChangePasswordController extends GetxController {
  final TextEditingController changeEditing = TextEditingController();
  var password = ''.obs;
  var isPasswordValid = false.obs;
  final RxBool isPasswordHidden = true.obs;

  // Password validation flags
  var isSixChars = false.obs;
  var hasNumberOrSpecial = false.obs;

  // Strength indicator
  var strengthProgress = 0.0.obs;
  var strengthColor = Color(0xFF4A4A4A).obs;
  var strengthLabel = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Listen to password changes
    password.listen((_) {
      validatePassword();
      updateStrength();
    });
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  // Check password validity
  void validatePassword() {
    // Check minimum 6 characters
    isSixChars.value = password.value.length >= 6;

    // Check for at least one number or special character
    final hasNumber = RegExp(r'\d').hasMatch(password.value);
    final hasSpecial = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password.value);
    hasNumberOrSpecial.value = hasNumber || hasSpecial;

    // Overall validity
    isPasswordValid.value = isSixChars.value && hasNumberOrSpecial.value;
  }

  // Update strength indicator
  void updateStrength() {
    final len = password.value.length;
    final hasUpper = RegExp(r'[A-Z]').hasMatch(password.value);
    final hasLower = RegExp(r'[a-z]').hasMatch(password.value);
    final hasNumber = RegExp(r'\d').hasMatch(password.value);
    final hasSpecial = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password.value);

    int strength = 0;

    if (len >= 6) strength++;
    if (len >= 10) strength++;
    if (hasUpper && hasLower) strength++;
    if (hasNumber) strength++;
    if (hasSpecial) strength++;

    // Update progress, color, and label based on strength
    if (strength <= 1) {
      strengthProgress.value = 0.3;
      strengthColor.value = Colors.red;
      strengthLabel.value = 'Weak';
    } else if (strength == 2 || strength == 3) {
      strengthProgress.value = 0.6;
      strengthColor.value = Colors.orange;
      strengthLabel.value = 'Fair';
    } else if (strength >= 4) {
      strengthProgress.value = 1.0;
      strengthColor.value = Colors.green;
      strengthLabel.value = 'Strong';
    }

    // Empty password
    if (len == 0) {
      strengthProgress.value = 0.7;
      strengthColor.value = AppColors.progressbarColor;
      strengthLabel.value = 'Fair';
    }
  }
}



