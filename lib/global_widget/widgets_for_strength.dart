import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordStrengthBar extends StatelessWidget {
  final int strength; // 0 = weak, 1 = fair, 2 = great

  const PasswordStrengthBar({super.key, required this.strength});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 400),
          height: 6.h,
          width: 220.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            color: _getBackgroundColor(strength),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 400),
              width: _getProgressWidth(strength),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.r),
                color: _getActiveColor(strength),
              ),
            ),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          _getLabel(strength),
          style: TextStyle(
            color: _getActiveColor(strength),
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  double _getProgressWidth(int s) {
    if (s == 0) return 70.w;     // weak
    if (s == 1) return 140.w;    // fair
    return 220.w;                // great
  }

  Color _getBackgroundColor(int s) {
    return Colors.grey.shade700; // background line
  }

  Color _getActiveColor(int s) {
    if (s == 0) return Colors.red;
    if (s == 1) return Colors.yellow.shade600;
    return Colors.green;
  }

  String _getLabel(int s) {
    if (s == 0) return "Weak";
    if (s == 1) return "Fair";
    return "Great";
  }
}
