import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../../views/account/change_email.dart';
import '../../views/account/contact_support.dart';
import '../../views/authentication/OtpVerification_Screen/OtpVerification_Screen.dart';
import '../../views/authentication/create_an_account/create_an_account.dart';
import '../../views/authentication/enter_email_screen/enter_email_screen.dart';
import '../../views/authentication/get_started_screen/get_started_screen.dart';
import '../../views/authentication/login_account/login_account.dart';
import '../../views/authentication/we_willbe_login/we_logged_you.dart';
import '../../views/home/account_screen/account_screen.dart';
import '../../views/home/history_screen/history_screen.dart';
import '../../views/home/home_new_routes/home_new_routes.dart';
import '../../views/splash_screen/splash_screen.dart';
import '../../views/subscription_plans/choose_team_plan/choose_team_plan.dart';
import '../../views/subscription_plans/choose_your_plan/choose_your_plan.dart';
import '../../views/subscription_plans/individualTeam.dart';

class AppRoutes {
  static const String splashScreen = "/SplashScreen";
  static const String getStartedScreen = "/GetStartedScreen";
  // ================== Enter Email screen =====================//
  static const String enterEmailScreen = "/EnterEmailScreen";
  static const String createAccountScreen = "/CreateAnAccount";
  static const String loginAccount = "/LoginAccount";
  static const String otpVerificationScreen = "/OtpVerificationScreen";
  static const String weLoggedYou = "/WeLoggedYou";
  static const String individualTeam = "/IndividualTeam";
  static const String chooseYourPlan = "/ChooseYourPlan";
  static const String chooseATeamPlan = "/ChooseATeamPlan";

  // ================= home teamManager ===========================
  static const String homeNewRoutes = "/HomeNewRoutes";
  static const String accountScreen = "/AccountScreen";
  static const String historyScreen = "/HistoryScreen";

  static const String welcomeScreen2 = "/WelcomeScreen2";
  static const String welcomePage = "/WelcomePage";

  // account all routes
  static const String contactSupport ="/ContactSupport";
  static const String changeEmail ="/ChangeEmail";

  // ================ login Screen part ================================

  // bridge
  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(name: getStartedScreen, page: () => GetStartedScreen()),
    GetPage(name: enterEmailScreen, page: () => EnterEmailScreen()),
    GetPage(name: createAccountScreen, page: () => CreateAnAccount()),
    GetPage(name: loginAccount, page: () => LoginAccount()),
    GetPage(name: otpVerificationScreen, page: () => OtpVerificationScreen()),
    GetPage(name: weLoggedYou, page: () => WeLoggedYou()),
    GetPage(name: individualTeam, page: () => IndividualTeam()),
    GetPage(name: chooseYourPlan, page: () => ChooseYourPlan()),
    GetPage(name: chooseATeamPlan, page: () => ChooseATeamPlan()),

    // HOME ROUTES
    GetPage(name: homeNewRoutes, page: () => HomeNewRoutes()),
    GetPage(name: accountScreen, page: () => AccountScreen()),
    GetPage(name: historyScreen, page: () => HistoryScreen()),

    // accounts all screen route
    GetPage(name: contactSupport, page:() => ContactSupport(),),
    GetPage(name: changeEmail, page:() => ChangeEmail(),)
  ];
}
