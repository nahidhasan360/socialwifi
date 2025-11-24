import 'package:get/get_navigation/src/routes/get_route.dart';

import '../../views/get_started_screen/get_started_screen.dart';
import '../../views/splash_screen/splash_screen.dart';



class AppRoutes {
  ///=========================== onboarding Part 1======================//
  static const String splashScreen = "/SplashScreen";
  static const String getStartedScreen = "/GetStartedScreen";

  // ================== welcome screen =====================//
  static const String welcomeScreen = "/WelcomeScreen";
  static const String welcomeScreen2 = "/WelcomeScreen2";
  static const String welcomePage = "/WelcomePage";

  // ================ login Screen part ================================

  // bridge

  static List<GetPage> routes = [
    ///=========================== onboarding Part 1  =======================//
    GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(name: getStartedScreen, page: () => GetStartedScreen()),

    // // ====================== welcome screen =============================
    // GetPage(name: welcomeScreen, page: () => WelcomeScreen()),
    // GetPage(name: welcomeScreen2, page: () => WelcomeScreen2()),
    // GetPage(name: welcomePage, page: () => WelcomePage()),
    //
    //
    // //=========================== Login ==============================
    // GetPage(name: login, page: () => LoginScreen()),
    // //================ otp screen ===============
    // GetPage(name: otpScreen, page: () => OtpScreen()),
    // GetPage(name: confirmScreen, page: () => ConfirmScreen()),
    //
    // /// ===================  forget password part ===========================
    // GetPage(name: forgetPasswordScreen, page: () => ForgetPassword()),
    // //=========================== forget otp screen ================ =========
    // GetPage(name: forgetPassOtp, page: () => ForgetPassOtp()),
    // GetPage(name: continueScreen, page: () => ContinueScreen()),
    // GetPage(name: setNewPassword, page: () => SetNewPassword()),
    // GetPage(name: successScreen, page: () => SuccessScreen()),



  ];
}
