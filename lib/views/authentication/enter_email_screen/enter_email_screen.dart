import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:right_routes/core/routes/all_routes.dart';
import 'package:right_routes/utils/assets_manager.dart';
import 'package:right_routes/utils/colors.dart';
import 'package:right_routes/views/authentication/enter_email_screen/widgets/continue_widgets.dart';
import 'enter_email_controller.dart';

class EnterEmailScreen extends StatelessWidget {
  final controller = Get.put(EnterEmailController());

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
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 15),

                  SizedBox(
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
                  SizedBox(height: 21),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Enter your email to continue',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      SizedBox(height: 21),
                      SizedBox(
                        child: Text(
                          'Log in to your Route Pilot account. If you don’t have one, you will be prompted to create one.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 28),
                  Container(
                    width: double.infinity,
                    constraints: BoxConstraints(
                      minHeight: 50,
                      maxHeight: 70,
                      maxWidth: 500, // iPad/tablet এ too wide না হয়
                    ),

                    // padding: EdgeInsets.only(
                    //   top: 13.h,
                    //   left: 15.w,
                    //   right: 10.w,
                    //   bottom: 10.h,
                    // ),
                    //
                    decoration: BoxDecoration(
                      color: AppColors.medGray,
                      borderRadius: BorderRadius.circular(10),
                    ),

                    child: TextFormField(
                      controller: controller.emailController,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,

                        // All screens এ stable line height
                        height: 1.4,
                        letterSpacing: 0.2,
                      ),

                      cursorColor: Color(0xFFFFFFFF),

                      // cursor never becomes too small or too large
                      cursorHeight: 22,
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: TextStyle(
                          color: Color(0xFFBFBFBF),
                          fontSize: 16,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w400,
                        ),

                        isDense: true,

                        // content padding
                        contentPadding: EdgeInsets.only(
                          top: 15,
                          left: 15,
                          right: 10,
                          bottom: 10,
                        ),

                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),

                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),

                  SizedBox(height: 25),
                  ContinueWidgets(
                    text: 'CONTINUE',
                   width: double.infinity,
                    onPressed: () {
                      Get.toNamed(AppRoutes.createAccountScreen);
                      print('button clicked');
                    },
                  ),

                  // SizedBox(height: 100,),
                  //
                  //
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text(
                  //       'Having  trouble? See our Help Page.',
                  //       textAlign: TextAlign.start,
                  //       style: TextStyle(
                  //         color:AppColors.purple,
                  //         fontSize: 16,
                  //         fontFamily: 'Lato',
                  //         fontWeight: FontWeight.w400,
                  //       ),
                  //     ),
                  //   ],
                  // ),




                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
