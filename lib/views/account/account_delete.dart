import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:right_routes/global_widgets/custom_navbar.dart';
import 'package:right_routes/utils/assets_manager.dart';
import 'package:right_routes/utils/colors.dart';
import '../../global_widgets/button_reusable.dart';


class AccountDelete extends StatelessWidget {
  const AccountDelete({super.key});


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body:  Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageManager.mapBackground),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(22.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 40),

                  /// LOGO
                  Center(
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
                  SizedBox(height: 32.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 397,
                        child: Text(
                          'Your Right Route account has\nbeen deleted',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28.sp,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w700,
                            height: 1,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      SizedBox( height: 13.h,),
                      Divider(color: AppColors.dividerColor, thickness: 1),
                      SizedBox( height: 17.h,),
                      Text(
                        'Please be sure to cancel your paid subscription at the app store you purchased it from.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w500,
                          height: 1.44,
                        ),
                      ),
                      SizedBox(height: 359 .h),

                      ButtonReusable(
                        onPressed: () => Get.back(),
                        text: 'EXIT',
                        width: 500.w,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),


        bottomNavigationBar:CustomNavbar()
    );
  }
}

