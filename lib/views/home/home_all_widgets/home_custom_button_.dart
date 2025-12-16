import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:right_routes/utils/colors.dart';

class SimpleImportButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final  VoidCallback? onTab;

  final String leftIcon;   // SVG or PNG
  final String? rightIcon; // SVG only

  const SimpleImportButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.leftIcon,
    this.rightIcon, this.onTab,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // BUTTON
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            height: 64,
            width: 296,
            decoration: BoxDecoration(
              color: const Color(0xFFFF8A3D),
              borderRadius: BorderRadius.circular(10    ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // LEFT ICON
                _buildLeftIcon(),

                const SizedBox(width: 4),

                // TEXT
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'Bebas Neue',
                    fontWeight: FontWeight.w400,
                    height: 1.17,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),

          // TOP-RIGHT QUESTION ICON (optional)
          Positioned(
            top: 7,
            right: 7,
            child: GestureDetector(
              onTap: onTab,
              child: Container(
                height: 22,
                width: 22,
                decoration: BoxDecoration(
                  color: AppColors.medGray,
                  border: BoxBorder.all(color: AppColors.white, width: 2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Icon(
                    Icons.question_mark,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )



        ],
      ),
    );
  }

  Widget _buildLeftIcon() {
    if (leftIcon.endsWith(".svg")) {
      return SvgPicture.asset(
        leftIcon,
        height: 30,
        width: 30,
        colorFilter:
        const ColorFilter.mode(Colors.white, BlendMode.srcIn),
      );
    } else {
      return Image.asset(
        leftIcon,
        height: 30,
        width: 30,
      );
    }
  }
}
