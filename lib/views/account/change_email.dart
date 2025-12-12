import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:right_routes/core/routes/all_routes.dart';
import 'package:right_routes/global_widgets/button_reusable.dart';
import 'package:right_routes/global_widgets/custom_buttons.dart';

import '../../../utils/assets_manager.dart';
import '../../global_widgets/custom_navbar.dart';
import '../../utils/colors.dart';

class ChangeEmail extends StatelessWidget {
  ChangeEmail({super.key});

  final emailController = Get.put(changeEmailController);

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
                SizedBox(height: 39.h),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 397,
                      child: Text(
                        'Change Email',
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
                    Divider(color: AppColors.dividerColor, thickness: 1),

                    Text(
                      'This replaces the email you use to log in to this app account.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w500,
                        height: 1.44,
                      ),
                    ),
                    SizedBox(height: 19.h),

                    Text(
                      'Current Right Route account email:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w500,
                        height: 1.40,
                      ),
                    ),
                    Text(
                      'tanvirhasancr@gmail.com',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w800,
                        height: 1.40,
                      ),
                    ),
                    SizedBox(height: 39.h),

                    Center(child: emailInputField(changeEmailController())),
                    SizedBox(height: 19),

                    ButtonReusable(
                      onPressed: () => AppRoutes.emailSaved,
                      text: 'SAVE & CONTINUE',
                      width: 500.w,
                    ),
                    SizedBox(height: 19.h),
                    ButtonReusable(
                      onPressed: () => '',
                      text: 'CANCEL',
                      width: 500.w,
                      fontSize: 24,
                      backgroundColor: AppColors.medGray,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomNavbar(),
    );
  }
}

class changeEmailController extends GetxController {
  RxBool obscure = true.obs;

  final emailController = TextEditingController();
}

Widget emailInputField(changeEmailController controller) {
  return Container(
    height: 57,
    padding: EdgeInsets.symmetric(horizontal: 16.w),
    decoration: BoxDecoration(
      color: AppColors.medGray, // same grey as screenshot
      borderRadius: BorderRadius.circular(10.r),
    ),
    child: Row(
      children: [
        /// ---- TEXT FIELD ----
        Expanded(
          child: TextFormField(
            controller: controller.emailController,
            style: TextStyle(color: Colors.white, fontSize: 16.sp),
            cursorColor: Colors.white,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Enter new email",
              hintStyle: TextStyle(
                color: const Color(0xFFBFBFBF),
                fontSize: 16,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w400,
                height: 1.75,
              ),
            ),
          ),
        ),

        /// ---- EYE ICON RIGHT SIDE ----
        Obx(
          () => GestureDetector(
            onTap: () => controller.obscure.toggle(),
            child: Icon(
              controller.obscure.value
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: Colors.white.withOpacity(0.8),
              size: 24.sp,
            ),
          ),
        ),
      ],
    ),
  );
}
