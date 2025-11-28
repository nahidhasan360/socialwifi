

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:right_routes/utils/colors.dart';

class TermsModal extends StatelessWidget {
  const TermsModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.darkGray,

      // Fullscreen Grey Overlay
      child: Stack(
        children: [

          /// ❌ Close Button (Top Right)
          Positioned(
            right: 18.w,
            top: 20.h,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                width: 30.w,
                height: 30.w,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close,
                  size: 20.sp,
                  color: Colors.black,
                ),
              ),
            ),
          ),

          /// FOREGROUND CONTENT (LEFT SIDE)
          Positioned(
            left: 0,
            right: 0,
            top: 65.h,
            bottom: 0,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// Title
                  Text(
                    "Terms of Service",
                    style: TextStyle(
                      fontSize: 21.sp,
                      fontWeight: FontWeight.w700,
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
                    "Real content coming later. Lorem ipsum fervidus solaria nunc et varius pellentesque auctor. "
                        "Quisque narium vibora set ultricies finibus larentum quisque dronelis. Pellentesque habitant "
                        "morbi tristique senectus et netus et malesuada fames ac turpis egestas. Curabitur flaminia set "
                        "vero donis quavara et ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae.\n\n"

                        "Sed ornare quistum valeris ligula faucibus venenatis veli set amet. Integer pluvina morkal sapien "
                        "vitae justo bibendum, id iaculis urna semper. Mauris dignissim tortor ac vespara fringilla, in porta "
                        "leo mattis. Proin gladius urna non massa aliquet, sit amet gravida arcu tempor. Nam convallis tortor "
                        "a lorem mattis blandit in id leo.\n\n"

                        "Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; vivamus "
                        "quastra enim at felis cursus, eget tristique nulla posuere. Fusce lorem gristum dapibus semper orci, "
                        "non ornare nisl pulvinar sit amet. Aenean sed purus quis arcu sodales fermentum nantris vehicula. "
                        "Cras dictum velora sapien, quis aliquet nulla tempor ut.",
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.white,
                      height: 1.45,
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
    );
  }
}
