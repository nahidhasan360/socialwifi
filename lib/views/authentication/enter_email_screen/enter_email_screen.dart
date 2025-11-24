
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:right_routes/core/routes/all_routes.dart';
import 'package:right_routes/utils/assets_manager.dart';
import 'package:right_routes/utils/colors.dart';

import '../../../global_widgets/custom_buttons.dart';
import 'enter_email_controller.dart';

class EnterEmailScreen extends StatelessWidget {
  EnterEmailScreen ({Key? key}) : super(key: key);

  final EmailController controller = Get.put(EmailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageManager.mapBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                SizedBox(height: 60.h),
                // Logo
                Image.asset(
                  ImageManager.splashScreenLogo,
                  width: 225.w,
                  height: 112.h,
                  fit: BoxFit.cover,
                ),

                SizedBox(height: 21.h),
                // Title
                SizedBox(
                  width: 392,
                  child: Text(
                    'Enter your email to continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.sp,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w700,
                      height: 1.12,
                    ),
                  ),
                ),

                SizedBox(height: 16.h),

                // Subtitle
                Text(
                  'Log in to your Route Pilot account. If you don\'t have one, you will be prompted to create one.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),

                SizedBox(height: 40.h),

                // Email TextField
                TextField(
                  controller: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 16.sp,
                    ),
                    filled: true,
                    fillColor: const Color(0xFF4A4A4A),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 18.h,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: const BorderSide(
                        color: AppColors.orange,
                        width: 1,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 24.h),

                // Continue Button
                CustomButton(
                  text: 'CONTINUE',
                  width: double.infinity,
                  height: 55.h,
                  fontSize: 20.sp,
                  onPressed: () {
                    controller.onContinue();
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