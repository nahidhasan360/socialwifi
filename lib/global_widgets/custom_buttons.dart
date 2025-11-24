import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:right_routes/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final Color backgroundColor;
  final Color textColor;
  final double? fontSize;
  final double borderRadius;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height,
    this.fontSize,
    this.backgroundColor = AppColors.orange, // Example Orange
    this.textColor = Colors.white,
    this.borderRadius = 10.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Container(
        width: 234.w,
        height: 58.h,
        padding: EdgeInsets.all(10.w),
        decoration: ShapeDecoration(
          color: AppColors.orange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 10.w),
            Text(
              'GET STARTED',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 24.sp,
                fontFamily: 'League Gothic',
                fontWeight: FontWeight.w400,
                height: 1.17,
                letterSpacing: 2.sp,
              ),
            ),
          ],
        ),
      );
  }
}
