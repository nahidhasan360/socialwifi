// lib/bindings/otp_verification_binding.dart
import 'package:get/get.dart';
import 'OtpVerificationController.dart';

class OtpVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtpVerificationScreenLoginController>(
          () => OtpVerificationScreenLoginController(),
      fenix: true,
    );
  }
}