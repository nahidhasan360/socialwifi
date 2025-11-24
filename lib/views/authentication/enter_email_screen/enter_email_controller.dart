// lib/controllers/auth/email_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailController extends GetxController {
  final emailController = TextEditingController();

  var isLoading = false.obs;

  void onContinue() {
    String email = emailController.text.trim();

    if (email.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your email',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar(
        'Error',
        'Please enter a valid email',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Navigate to next screen
    // Get.to(() => PasswordScreen());
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}