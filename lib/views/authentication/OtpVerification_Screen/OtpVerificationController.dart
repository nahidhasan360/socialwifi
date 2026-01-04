// OtpVerificationController.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:right_routes/core/routes/all_routes.dart';

class OtpVerificationScreenLoginController extends GetxController {
  final TextEditingController otpController = TextEditingController();
  final RxString otp = ''.obs;
  final RxBool isLoading = false.obs;

  String email = '';

  @override
  void onInit() {
    super.onInit();
    email = Get.arguments ?? 'tanvirhasancr8****@gmail.com';
  }

  void onOtpChanged(String value) {
    otp.value = value;
  }

  Future<void> verifyOtp() async {
    if (otp.value.length != 6) {
      Get.snackbar('Error', 'Please enter 6-digit OTP');
      return;
    }

    try {
      isLoading.value = true;

      // Your API call here
      // await apiService.verifyOtp(email: email, otp: otp.value);

      await Future.delayed(Duration(seconds: 1)); // Simulate API call

      Get.offAllNamed(AppRoutes.loginAccount);
    } catch (e) {
      Get.snackbar('Error', 'Invalid OTP. Please try again');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resendOtp() async {
    try {
      isLoading.value = true;

      // Your API call here
      // await apiService.resendOtp(email: email);

      await Future.delayed(Duration(seconds: 1)); // Simulate API call

      otpController.clear();
      otp.value = '';

      Get.snackbar('Success', 'OTP has been resent to your email');
    } catch (e) {
      Get.snackbar('Error', 'Failed to resend OTP');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    // Don't dispose controller here when using GetX
    super.onClose();
  }
}