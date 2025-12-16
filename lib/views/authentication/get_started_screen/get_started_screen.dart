import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:right_routes/core/routes/all_routes.dart';
import 'package:right_routes/global_widgets/custom_buttons.dart';
import '../../../utils/assets_manager.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Common Text Styles
     TextStyle titleStyle = TextStyle(
      color: Colors.white,
      fontSize: 32.sp,
      fontFamily: 'League Gothic',
      fontWeight: FontWeight.w400,
      height: 1.25,
      letterSpacing: 1,
    );

     TextStyle bodyStyle = TextStyle(
       color: Colors.white,
       fontSize: 20.sp,
       fontFamily: 'Lato',
       fontWeight: FontWeight.w500,
       height: 1.40,
    );

    const TextStyle subBodyStyle = TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontFamily: 'Lato',
      fontWeight: FontWeight.w500,
      height: 1.44,
    );

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
                SizedBox(height: 40.h,),
              /// Sticky Logo
              Container(
                width: 225,
                height: 112,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(ImageManager.splashScreenLogo),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              /// Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment:  MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 30),
          
                      /// Title
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text.rich(
                          TextSpan(
                            text:
                            'EXPERIENCE THE EASE OF\nAUTOMATED VISUAL AND VOICE\nGUIDED PERMITTED ROUTE\nNAVIGATION',
                            style: titleStyle,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 19.h),
          
                      /// Description
                      SizedBox(
                        width: 330,
                        child: Text(
                          'Start automated routing with your 7-\nday free trial, then \$14.99/mo for\nindividuals.',
                          style: bodyStyle.copyWith(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 19),
          
                      /// Companies Info
                      SizedBox(
                        width: 263,
                        child: Text(
                          'Companies: See pricing tiers\nafter sign-up.',
                          style: subBodyStyle.copyWith(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 19.h),
          
                      /// Get Started Button
                      CustomButton(
                        text: "Get Started",
                        width: 134,
                        height: 58,
                        fontSize: 24,
                        onPressed: () {
                          Get.toNamed(AppRoutes.enterEmailScreen);
                        },
                      ),
                      SizedBox(height: 100),
          
                      /// Already a Subscriber
                      SizedBox(
                        width: 160,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Already a Subscriber?\n',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.w500,
                                  height: 1.75,
                                ),
                              ),
                              TextSpan(
                                text: 'SIGN IN ',
                                style: const TextStyle(
                                  color: Color(0xFF9DACF5),
                                  fontSize: 20,
                                  fontFamily: 'League Gothic',
                                  fontWeight: FontWeight.w400,
                                  height: 1.40,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Navigate to Sign In screen
                                    Get.toNamed(AppRoutes.enterEmailScreen);
                                  },
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
