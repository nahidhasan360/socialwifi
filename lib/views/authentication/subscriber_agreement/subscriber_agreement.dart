

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:right_routes/utils/colors.dart';
import 'package:flutter_svg/svg.dart';

class SubscriberAgreement extends StatelessWidget {
  const SubscriberAgreement({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Material(
        color: AppColors.darkGray,

        // Fullscreen Grey Overlay
        child: Stack(
          children: [
            SizedBox( height: 80,),

            /// ❌ Close Button (Top Right)
            Positioned(
              right: 12.w,
              top: 40.h,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: IconButton(
                  padding: EdgeInsets.zero, // removes extra padding
                  onPressed: () => Get.back(),

                  icon: SvgPicture.asset(
                    "assets/icons/Close-X-Circle.svg",
                    width: 29.w,
                    height: 29.h,
                  ),
                ),
              ),
            ),

            /// FOREGROUND CONTENT (LEFT SIDE)
            Positioned(
              left: 0,
              right: 0,
              top: 72.h,
              bottom: 0,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// Title
                    Text(
                      "Subscriber Agreement",
                      style: TextStyle(
                        fontSize: 21.sp,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w700,
                        height: 1.17,
                        color: Colors.white,
                      ),
                    ),

                    SizedBox(height: 10.h),

                    /// Divider
                    Divider(
                      thickness: 1,
                      color: AppColors.dividerColor,

                    ),

                    SizedBox(height: 12.h),

                    /// Static Terms Content (Pixel-Perfect)
                    Text(
                      "Content coming",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w500,
                        height: 1.44,
                      ),
                    ),

                    SizedBox(height: 40.h),

                    /// =========== (Optional Dynamic Version - commented out) ===========
                    ///
                    /// EXAMPLE dynamic title:
                    /// Obx(() => Text(controller.dialogTitle.value, style: ...))
                    ///
                    /// EXAMPLE dynamic content:
                    /// Obx(() => Text(controller.dialogContent.value, style: ...))
                    ///
                    /// ================================================================

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
