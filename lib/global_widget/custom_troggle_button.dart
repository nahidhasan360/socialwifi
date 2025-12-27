import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

/// ==================== Advanced Custom Toggle Switch with SVG ====================
/// Professional toggle switch with SVG icon support

class CustomToggleSwitchAdvanced extends StatelessWidget {
  final RxBool value;
  final ValueChanged<bool>? onChanged;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? thumbColor;
  final double? width;
  final double? height;
  final Duration? duration;
  final Widget? activeIcon;
  final Widget? inactiveIcon;
  final String? activeSvgPath;
  final String? inactiveSvgPath;
  final Color? svgColor;
  final bool showShadow;

  const CustomToggleSwitchAdvanced({
    Key? key,
    required this.value,
    this.onChanged,
    this.activeColor,
    this.inactiveColor,
    this.thumbColor,
    this.width,
    this.height,
    this.duration,
    this.activeIcon,
    this.inactiveIcon,
    this.activeSvgPath,
    this.inactiveSvgPath,
    this.svgColor,
    this.showShadow = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => GestureDetector(
        onTap: () {
          if (onChanged != null) {
            value.value = !value.value;
            onChanged!(value.value);
          }
        },
        child: AnimatedContainer(
          duration: duration ?? Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: width ?? 60,
          height: height ?? 32,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular((height ?? 32) / 2),
            color: value.value
                ? (activeColor ?? Color(0xFFFF8C42))
                : (inactiveColor ?? Colors.grey.withOpacity(0.3)),
          ),
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: duration ?? Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                left: value.value ? (width ?? 60) - (height ?? 32) + 2 : 2,
                top: 2,
                child: Container(
                  width: (height ?? 32) - 4,
                  height: (height ?? 32) - 4,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: thumbColor ?? Colors.white,
                    boxShadow: showShadow
                        ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ]
                        : null,
                  ),
                  child: Center(
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 200),
                      transitionBuilder: (child, animation) {
                        return ScaleTransition(
                          scale: animation,
                          child: child,
                        );
                      },
                      child: _buildIcon(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    // If SVG path is provided, use SVG
    if (value.value && activeSvgPath != null) {
      return SvgPicture.asset(
        activeSvgPath!,
        key: ValueKey('active_svg'),
        width: 20,
        height: 20,
        colorFilter: ColorFilter.mode(
          svgColor ?? Color(0xFFFF8C42),
          BlendMode.srcIn,
        ),
      );
    }

    if (!value.value && inactiveSvgPath != null) {
      return SvgPicture.asset(
        inactiveSvgPath!,
        key: ValueKey('inactive_svg'),
        width: 16,
        height: 16,
        colorFilter: ColorFilter.mode(
          svgColor ?? Colors.grey,
          BlendMode.srcIn,
        ),
      );
    }

    // Otherwise use icon widget
    if (value.value && activeIcon != null) {
      return activeIcon!;
    }

    if (!value.value && inactiveIcon != null) {
      return inactiveIcon!;
    }

    return SizedBox.shrink();
  }
}


/// ==================== Usage Examples ====================

/// Example 1: With SVG Icon
class ToggleWithSVG extends StatelessWidget {
  final controller = Get.put(ToggleController());

  @override
  Widget build(BuildContext context) {
    return CustomToggleSwitchAdvanced(
      value: controller.isEnabled,
      onChanged: (val) {
        print('Toggle: $val');
      },
      activeSvgPath: 'assets/icons/check_icon.svg',
      svgColor: Color(0xFFFF8C42),
      activeColor: Color(0xFFFF8C42),
      inactiveColor: Colors.white.withOpacity(0.3),
    );
  }
}


/// Example 2: With Material Icon
class ToggleWithIcon extends StatelessWidget {
  final controller = Get.put(ToggleController());

  @override
  Widget build(BuildContext context) {
    return CustomToggleSwitchAdvanced(
      value: controller.isEnabled,
      onChanged: (val) {},
      activeIcon: Icon(
        Icons.check,
        color: Color(0xFFFF8C42),
        size: 16,
      ),
      activeColor: Color(0xFFFF8C42),
      inactiveColor: Colors.white.withOpacity(0.3),
    );
  }
}


/// Example 3: Complete Touch ID Toggle (Screenshot Match)
class TouchIDToggleComplete extends StatelessWidget {
  final controller = Get.put(ToggleController());

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomToggleSwitchAdvanced(
          value: controller.useTouchId,
          onChanged: (val) {
            print('Touch ID: $val');
          },
          width: 60,
          height: 32,
          activeColor: Color(0xFFFF8C42),
          inactiveColor: Colors.white.withOpacity(0.3),
          thumbColor: Colors.white,
          // Use SVG if available
          activeSvgPath: 'assets/icons/check_icon.svg',
          svgColor: Color(0xFFFF8C42),
          // Or use Material Icon as fallback
          activeIcon: Icon(
            Icons.check,
            color: Color(0xFFFF8C42),
            size: 16,
          ),
        ),
        SizedBox(width: 10),
        Text(
          'Use touch ID',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}


/// Controller
class ToggleController extends GetxController {
  var isEnabled = false.obs;
  var useTouchId = false.obs;
}

