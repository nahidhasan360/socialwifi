import 'package:flutter/material.dart';
import 'package:right_routes/utils/colors.dart';

class ButtonReusable extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  // optional inputs but default stays the same UI
  final double width;
  final double height;
  final double padding;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  final double borderRadius;

  const ButtonReusable({
    Key? key,
    required this.text,
    required this.onPressed,
    this.width = 234,
    this.height = 58,
    this.padding = 10,
    this.backgroundColor = const Color(0xFFF58842),
    this.textColor = Colors.white,
    this.fontSize = 24,
    this.borderRadius = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(padding),
        decoration: ShapeDecoration(
          color: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                  fontSize: fontSize,
                  fontFamily: 'League Gothic',
                  fontWeight: FontWeight.w400,
                  height: 1.17,
                  letterSpacing: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
