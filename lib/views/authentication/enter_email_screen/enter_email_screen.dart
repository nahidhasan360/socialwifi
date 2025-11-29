import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:right_routes/core/routes/all_routes.dart';
import 'package:right_routes/utils/assets_manager.dart';
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
          padding: EdgeInsets.all(22),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 40),

                SizedBox(
                  child:Container(
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
                  SizedBox(
                    width: 392,
                    child: Text(
                      'Enter your email to continue',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w700,
                        height: 1.12,
                      ),
                    ),
                  ),

                  SizedBox(height: 28.h),
                  SizedBox(
                    width: 392,
                    child: Text(
                      'Log in to your Route Pilot account. If you don’t have one, you will be prompted to create one.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w500,
                        height: 1.56,
                      ),
                    ),
                  ),
                ],
               ),
                SizedBox(height: 28.h),
                Container(
                  width: 393,
                  height: 57, // responsive full width
                  constraints: BoxConstraints(
                    minHeight: 50.h,
                    maxHeight: 70.h,
                    maxWidth: 500.w, // iPad/tablet এ too wide না হয়
                  ),

                  // padding: EdgeInsets.only(
                  //   top: 13.h,
                  //   left: 15.w,
                  //   right: 10.w,
                  //   bottom: 10.h,
                  // ),
                  //
                  decoration: BoxDecoration(
                    color: const Color(0xFF606060),
                    borderRadius: BorderRadius.circular(10.r),
                  ),

                  child: TextFormField(
                    controller: controller.emailController,
                    style: TextStyle(
                      color: Colors.white,
                      // iPhone ছোট → ছোট font
                      // iPad বড় → large font, but not too big
                      fontSize:16,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w400,

                      // All screens এ stable line height
                      height: 1.4,
                      letterSpacing: 0.2,
                    ),

                    cursorColor: const Color(0xFFBFBFBF),

                    // cursor never becomes too small or too large
                    cursorHeight: 22,
                    decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: TextStyle(
                        color: const Color(0xFFBFBFBF),
                        fontSize: 16,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                        height: 1.75,
                      ),

                      isDense: true,

                      // content padding
                      contentPadding: EdgeInsets.only(
                        top: 15.h,
                        left: 15.w,
                        right: 10.w,
                        bottom: 10.h,),

                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),

                    keyboardType: TextInputType.emailAddress,
                  ),
                ),

                SizedBox(height: 25.h),
                ContinueWidgets(
                  text: 'CONTINUE',
                  width: 393,
                  height: 58,
                  onPressed: () {
                    Get.toNamed(AppRoutes.createAccountScreen);
                    print('button clicked');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
