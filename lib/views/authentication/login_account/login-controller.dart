import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:right_routes/core/routes/all_routes.dart';

class LoginController extends GetxController {

  // email store
  var userEmail = "".obs;

  void setEmail(String email) {
    userEmail.value = email.trim();
    update();
  }
  void clearEmail(){
    userEmail.value = '';


  }




  // Password visibility toggle
  RxBool hidePassword = true.obs;

  // Touch ID enabled state
  RxBool isTouchIDEnabled = false.obs;

  // Biometric authentication instance
  final LocalAuthentication auth = LocalAuthentication();

  // Check if biometric is available
  RxBool canCheckBiometrics = false.obs;
  RxBool isBiometricSupported = false.obs;

  // Available biometric types
  RxList<BiometricType> availableBiometrics = <BiometricType>[].obs;

  @override
  void onInit() {
    super.onInit();
    initializeBiometrics();
  }

  void togglePassword() {
    hidePassword.value = !hidePassword.value;
  }

  void toggleTouchID(bool value) {
    isTouchIDEnabled.value = value;
    print('✅ Touch ID enabled: $value');
  }

  // Initialize all biometric checks
  Future<void> initializeBiometrics() async {
    await checkBiometricSupport();
    await checkAvailableBiometrics();
  }

  // Check if device supports biometric authentication
  Future<void> checkBiometricSupport() async {
    try {
      canCheckBiometrics.value = await auth.canCheckBiometrics;
      isBiometricSupported.value = await auth.isDeviceSupported();

      print('🔐 === BIOMETRIC SUPPORT CHECK ===');
      print('📱 Device supported: ${isBiometricSupported.value}');
      print('✋ Can check biometrics: ${canCheckBiometrics.value}');

    } catch (e) {
      print('❌ Error checking biometric support: $e');
      canCheckBiometrics.value = false;
      isBiometricSupported.value = false;
    }
  }

  // Check available biometric types
  Future<void> checkAvailableBiometrics() async {
    try {
      List<BiometricType> biometrics = await auth.getAvailableBiometrics();
      availableBiometrics.value = biometrics;

      print('📋 === AVAILABLE BIOMETRICS ===');

      if (biometrics.isEmpty) {
        print('❌ No biometrics enrolled on this device');
        print('⚠️ User needs to add fingerprint/face in device settings');
      } else {
        if (biometrics.contains(BiometricType.fingerprint)) {
          print('👆 ✅ Fingerprint available');
        }
        if (biometrics.contains(BiometricType.face)) {
          print('😀 ✅ Face ID available');
        }
        if (biometrics.contains(BiometricType.iris)) {
          print('👁️ ✅ Iris scanner available');
        }
        if (biometrics.contains(BiometricType.strong)) {
          print('💪 ✅ Strong biometric available');
        }
        if (biometrics.contains(BiometricType.weak)) {
          print('⚡ ✅ Weak biometric available');
        }
      }
      print('=================================');

    } catch (e) {
      print('❌ Error getting available biometrics: $e');
    }
  }

  // Authenticate with biometrics
  Future<bool> authenticateWithBiometrics() async {
    try {
      print('\n🚀 === STARTING BIOMETRIC AUTHENTICATION ===');
      print('📱 Device supported: ${isBiometricSupported.value}');
      print('✋ Can check biometrics: ${canCheckBiometrics.value}');
      print('📋 Available biometrics: ${availableBiometrics.length}');

      // Check if biometric is available
      if (!canCheckBiometrics.value) {
        print('❌ FAILED: Biometric not available on device');
        Get.snackbar(
          'Not Available',
          'Biometric authentication is not available on this device',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3),
          margin: EdgeInsets.all(10),
        );
        return false;
      }

      // Check if any biometrics are enrolled
      if (availableBiometrics.isEmpty) {
        print('❌ FAILED: No biometrics enrolled');
        Get.snackbar(
          'Setup Required',
          'Please add fingerprint or face ID in your device settings first',
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 4),
          margin: EdgeInsets.all(10),
        );
        return false;
      }

      print('👆 Prompting user for biometric authentication...');

      // Authenticate
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Please authenticate to login to Right Routes',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
          useErrorDialogs: true,
          sensitiveTransaction: false,
        ),
      );

      print('📊 Authentication result: $didAuthenticate');

      if (didAuthenticate) {
        print('✅ ✅ ✅ AUTHENTICATION SUCCESSFUL! ✅ ✅ ✅');

        // Show success snackbar
        Get.snackbar(
          'Success!',
          'Fingerprint authentication successful!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 2),
          margin: EdgeInsets.all(10),
          icon: Icon(Icons.check_circle, color: Colors.white, size: 35),
          shouldIconPulse: true,
        );

        // Wait a bit before navigation
        await Future.delayed(Duration(milliseconds: 800));

        print('🚀 Navigating to OTP screen...');
        Get.toNamed(AppRoutes.otpVerificationScreen);

        return true;

      } else {
        print('❌ Authentication failed - User cancelled or didn\'t match');
        Get.snackbar(
          'Authentication Failed',
          'Fingerprint not recognized. Please try again.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 2),
          margin: EdgeInsets.all(10),
        );
        return false;
      }

    } on PlatformException catch (e) {
      print('⚠️ === PLATFORM EXCEPTION ===');
      print('Error code: ${e.code}');
      print('Error message: ${e.message}');
      print('Error details: ${e.details}');

      String errorMessage = 'Authentication error';

      // Handle specific error codes
      switch (e.code) {
        case 'NotAvailable':
          errorMessage = 'Biometric authentication is not available';
          break;
        case 'NotEnrolled':
          errorMessage = 'No fingerprint enrolled. Please add one in settings';
          break;
        case 'LockedOut':
          errorMessage = 'Too many attempts. Please try again later';
          break;
        case 'PermanentlyLockedOut':
          errorMessage = 'Biometric authentication is locked. Use device password';
          break;
        case 'PasscodeNotSet':
          errorMessage = 'Please set up a passcode on your device first';
          break;
        default:
          errorMessage = e.message ?? 'Authentication error occurred';
      }

      Get.snackbar(
        'Error',
        errorMessage,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
        margin: EdgeInsets.all(10),
      );
      return false;

    } catch (e) {
      print('💥 === GENERAL ERROR ===');
      print('Error: $e');

      Get.snackbar(
        'Error',
        'An unexpected error occurred during authentication',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 2),
        margin: EdgeInsets.all(10),
      );
      return false;
    }
  }
}