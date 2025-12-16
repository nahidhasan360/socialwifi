// ==================== Controller ====================
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:right_routes/utils/colors.dart';

import '../privacy_policy/privacy_policy.dart';
import '../terms_of_service/terms_of_service.dart';

class CreatePasswordController extends GetxController {
  final TextEditingController passwordController = TextEditingController();
  final RxString email = 'tanvirhasan890@gmail.com'.obs;
  final RxString password = ''.obs;
  final RxBool isPasswordHidden = true.obs;
  final RxBool isSixChars = false.obs;
  final RxBool hasNumberOrSpecial = false.obs;
  final RxBool useTouchId = true.obs;
  final RxBool agreeTerms = false.obs;
  final RxBool agreePrivacy = false.obs;

  // Password Strength
  final RxString strengthLabel = "".obs;  // default
  final RxDouble strengthProgress = 0.0.obs;
  final Rx<Color> strengthColor = AppColors.medGray.obs;



  bool get isFormValid =>
      isSixChars.value &&
          hasNumberOrSpecial.value &&
          agreeTerms.value &&
          agreePrivacy.value;

  @override
  void onInit() {
    super.onInit();
    password.listen((_) {
      validatePassword();
      updatePasswordStrength();
    });
  }

  void validatePassword() {
    isSixChars.value = password.value.length >= 6;

    final hasLetter = RegExp(r'[a-zA-Z]').hasMatch(password.value);
    final hasNumberOrChar = RegExp(
      r'[0-9!@#\$%^&*(),.?":{}|<>]',
    ).hasMatch(password.value);
    hasNumberOrSpecial.value = hasLetter && hasNumberOrChar;
  }

  void updatePasswordStrength() {
    if (password.value.isEmpty) {
      strengthLabel.value = '';
      strengthProgress.value = 0.0;
      strengthColor.value = Color(0xFF4A4A4A);
      return;
    }

    int strength = 0;

    // Check different criteria
    if (password.value.length >= 6) strength++;
    if (password.value.length >= 8) strength++;
    if (RegExp(r'[a-z]').hasMatch(password.value)) strength++;
    if (RegExp(r'[A-Z]').hasMatch(password.value)) strength++;
    if (RegExp(r'[0-9]').hasMatch(password.value)) strength++;
    if (RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password.value)) strength++;

    // Update strength based on score
    if (strength <= 2) {
      // Weak - Red
      strengthLabel.value = 'Weak';
      strengthProgress.value = 0.33;
      strengthColor.value = Color(0xFFE20202);
    } else if (strength <= 4) {
      // Fair - Yellow
      strengthLabel.value = 'Fair';
      strengthProgress.value = 0.66;
      strengthColor.value = Color(0xFFFFC700);
    } else {
      // Strong - Green
      strengthLabel.value = 'Strong';
      strengthProgress.value = 1.0;
      strengthColor.value = Color(0xFF19D503);
    }
  }

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void editEmail() {
    Get.back();
    print('Its clicked ');
  }

  void viewTermsOfUse() {
    Get.to(() => TermsModal());
  }

  void viewPrivacyPolicy() {
    Get.to(() => PrivacyPolicy());

  }



  void createAccount() {
    Get.snackbar(
      'Success',
      'Account created successfully!',
      backgroundColor: Color(0xFFFF6B35),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
    Get.offAllNamed('/home');
  }

  @override
  void onClose() {
    passwordController.dispose();
    super.onClose();
  }
}