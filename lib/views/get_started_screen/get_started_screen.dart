import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:right_routes/global_widgets/custom_buttons.dart';

import '../../utils/assets_manager.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Shared text style for all TextSpans
    const TextStyle commonStyle = TextStyle(
      color: Colors.white,
      fontSize: 32,
      fontFamily: 'League Gothic',
      fontWeight: FontWeight.w400,
      height: 1.25,
      letterSpacing: 1,
    );
    return Scaffold(
      body: Container(
        width: double.infinity.w,
        height: double.infinity.h,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageManager.mapBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo
            Container(
              width: 225.w,
              height: 112.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImageManager.splashScreenLogo),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 25.h),
            // Text Rich
            SizedBox(
              width: 330.w,
              child: Text.rich(
                TextSpan(
                  children: const [
                    TextSpan(
                      text:
                          'EXPERIENCE THE EASE OF\nAUTOMATED VISUAL AND VOICE\nGUIDED PERMITTED ROUTE\nNAVIGATION',
                      style: commonStyle,
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),

            SizedBox(height: 19.h),

            SizedBox(
              width: 330,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          'Start automated routing with your 7-day free trial, then \$14.99/mo for individuals.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w500,
                        height: 1.40,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),

            SizedBox(height: 19.h),
            SizedBox(
              width: 263,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Companies: See pricing tiers\nafter sign-up.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w500,
                        height: 1.44,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 19.h),
            CustomButton(
              text: "Get Started",
              height: 55.h,
              width: 234.w,
              onPressed: () {},
            ),
            SizedBox(height: 130.h),
            // Your widget
            Container(
              width: 206.w,
              height: 55.h,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 12,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Already a Subscriber?\n',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w500,
                            height: 1.75,
                          ),
                        ),
                        TextSpan(
                          text: 'SIGN IN ',
                          style: TextStyle(
                            color: const Color(0xFF9DACF5),
                            fontSize: 20.sp,
                            fontFamily: 'League Gothic',
                            fontWeight: FontWeight.w400,
                            height: 1.40,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print('Sign In clicked');
                              // Get.toNamed('/signin');
                            },
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
