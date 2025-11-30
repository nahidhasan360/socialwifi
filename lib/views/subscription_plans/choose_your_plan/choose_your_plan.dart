import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:right_routes/utils/colors.dart';

import '../../../global_widgets/button_reusable.dart';
import '../../../utils/assets_manager.dart';

class PlanController extends GetxController {
  RxString selected = "".obs;
}

class ChooseYourPlan extends StatelessWidget {
  const ChooseYourPlan({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PlanController());

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
          padding: const EdgeInsets.all(22),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 44),

                /// Logo
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
                SizedBox(height: 29),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      /// Title
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Text(
                          'CHOOSE YOUR PLAN',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontFamily: 'League Gothic',
                            fontWeight: FontWeight.w400,
                            height: 0.88,
                            letterSpacing: 1,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 21),

                      /// Subtitle
                      Text(
                        'Start your 7-day free trial and begin\nautomating your routes. Cancel anytime.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w500,
                          height: 1.56,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16.h),

                      Text(
                        'Individual Plan Options',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w700,
                          height: 1.10,
                        ),
                      ),

                      SizedBox(height: 30.h),

                      /// ANNUAL PLAN TILE
                      Obx(
                        () => _planTile(
                          title: "ANNUAL PLAN",
                          price: "\$119.99/YR",
                          badge: "Save 33%",
                          selected: controller.selected.value == "annual",
                          onTap: () => controller.selected.value = "annual",
                        ),
                      ),

                      SizedBox(height: 20.h),

                      /// MONTHLY PLAN TILE
                      Obx(
                        () => _planTile(
                          title: "MONTHLY PLAN",
                          price: "\$14.99/MO",
                          badge: null,
                          selected: controller.selected.value == "monthly",
                          onTap: () => controller.selected.value = "monthly",
                        ),
                      ),

                      SizedBox(height: 9.h),

                      TextButton(
                        onPressed: () {
                          // planController.restoreSubscription();
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'By clicking "Subscribe", you agree to the',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 19.sp,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w500,
                                height: 1.67,
                              ),
                            ),
                            Text(
                              'RIGHT ROUTE SUBSCRIBER AGREEMENT',
                              style: TextStyle(
                                color: AppColors.purple,
                                fontSize: 20,
                                fontFamily: 'League Gothic',
                                fontWeight: FontWeight.w400,
                                height: 1.50,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24),
                      ButtonReusable(text: 'SUBSCRIBE', onPressed: () {}, width: 250, height: 55,),
                      SizedBox(height: 6),
                      TextButton(
                        onPressed: () {
                          // planController.restoreSubscription();
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'RIGHT ROUTE SUBSCRIBER AGREEMENT',
                              style: TextStyle(
                                color: AppColors.purple,
                                fontSize: 20.sp,
                                fontFamily: 'League Gothic',
                                fontWeight: FontWeight.w400,
                                height: 1.50,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 85,),
                      TextButton(
                        onPressed: () {
                          // planController.restoreSubscription();
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Already a subscriber?',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.sp,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w500,
                                height: 1.75,
                              ),
                            ),
                            Text(
                              'RESTORE SUBSCRIPTION',
                              style: TextStyle(
                                color: const Color(0xFF9DACF5),
                                fontSize: 19.sp,
                                fontFamily: 'League Gothic',
                                fontWeight: FontWeight.w400,
                                height: 1.40,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 49.h),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// REUSABLE PLAN TILE (STATIC INSIDE THIS FILE)
Widget _planTile({
  required String title,
  required String price,
  required bool selected,
  required VoidCallback onTap,
  String? badge,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 392,
      height: 76,
      padding: EdgeInsets.symmetric(horizontal: 13.w),
      decoration: BoxDecoration(
        color: selected ? AppColors.orange : AppColors.darkGray,
        // borderRadius: BorderRadius.circular(10.r),
        border: Border.all(width: 1, color: AppColors.medGray),
      ),

      child: Row(
        children: [
          /// LEFT SIDE CIRCLE (CHECK)
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: selected
                  ? Border.all(color: Colors.white, width: 2)
                  : null,
              color: selected ? Colors.transparent : Colors.grey.shade500,
            ),
            child: selected
                ? const Icon(Icons.check, size: 18, color: Colors.white)
                : null,
          ),

          SizedBox(width: 15.w),

          /// TITLE
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontFamily: 'League Gothic',
              fontWeight: FontWeight.w400,
              height: 1.17,
              letterSpacing: 1,
            ),
          ),

          const Spacer(),

          /// PRICE + OPTIONAL BADGE
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontFamily: 'League Gothic',
                  fontWeight: FontWeight.w400,
                  height: 0.88,
                  letterSpacing: 1,
                ),
              ),

              if (badge != null)
                Container(
                  margin: EdgeInsets.only(top: 6),
                  padding: EdgeInsets.symmetric(horizontal: 9, vertical: 0),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Text(
                    badge,
                    style: TextStyle(
                      color: AppColors.medGray,
                      fontSize: 16,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w700,
                      height: 1.75,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    ),
  );
}
