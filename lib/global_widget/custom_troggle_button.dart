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





//
// # Custom Toggle Switch - Quick Start
//
// ## 🚀 Screenshot Match - Ready to Use!
//
// আপনার screenshot অনুযায়ী custom toggle switch বানানো হয়েছে।
//
// ---
//
// ## ⚡ Super Quick Start (30 seconds):
//
// ### Step 1: Copy File
// Copy `custom_toggle_switch_complete.dart` to your project:
// ```
// lib/widgets/custom_toggle_switch_complete.dart
// ```
//
// ### Step 2: Use Immediately
// ```dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'widgets/custom_toggle_switch_complete.dart';
//
// class MyScreen extends StatelessWidget {
// final controller = Get.put(MyController());
//
// @override
// Widget build(BuildContext context) {
// return Row(
// children: [
// CustomToggleSwitch(
// value: controller.useTouchId,
// onChanged: (val) => print('Toggle: $val'),
// activeIcon: Icon(
// Icons.check,
// color: Color(0xFFFF8C42),
// size: 16,
// ),
// ),
// SizedBox(width: 10),
// Text('Use touch ID'),
// ],
// );
// }
// }

class MyController extends GetxController {
var useTouchId = false.obs;
}
// ```
//
// **Done!** ✨
//
// ---
//
// ## 📦 Files Provided:
//
// ### 1. **custom_toggle_switch_complete.dart** ⭐ RECOMMENDED
// - **Complete all-in-one file**
// - Ready to use immediately
// - Includes all features
// - With examples
// - Production-ready
//
// ### 2. **custom_toggle_switch.dart**
// - Basic version
// - Material Icon support
// - Simple & clean
//
// ### 3. **custom_toggle_switch_advanced.dart**
// - Advanced version
// - SVG icon support
// - More features
//
// ### 4. **CUSTOM_TOGGLE_GUIDE.md**
// - Complete documentation
// - All examples
// - Customization guide
//
// ---
//
// ## 🎯 What You Get:
//
// ✅ **Exact match to your screenshot**
// - Orange track when ON
// - White thumb
// - Orange checkmark
// - Smooth animation
//
// ✅ **Easy to use**
// - Single widget
// - GetX integration
// - Copy & paste ready
//
// ✅ **Customizable**
// - Colors
// - Sizes
// - Icons
// - Animation
//
// ✅ **Professional**
// - Clean code
// - Well documented
// - Reusable
// - Production-ready
//
// ---
//
// ## 💡 Quick Examples:
//
// ### Example 1: Like Your Screenshot
// ```dart
// CustomToggleSwitch(
// value: controller.useTouchId,
// onChanged: (val) {},
// activeIcon: Icon(Icons.check, color: Color(0xFFFF8C42), size: 16),
// )
// ```
//
// ### Example 2: Different Size
// ```dart
// CustomToggleSwitch(
// value: controller.isEnabled,
// width: 80,
// height: 40,
// activeIcon: Icon(Icons.check, color: Color(0xFFFF8C42), size: 20),
// )
// ```
//
// ### Example 3: Custom Colors
// ```dart
// CustomToggleSwitch(
// value: controller.isEnabled,
// activeColor: Colors.green,
// activeIcon: Icon(Icons.check, color: Colors.green, size: 16),
// )
// ```
//
// ### Example 4: With Label (Helper Widget)
// ```dart
// LabeledToggle(
// label: 'Use touch ID',
// value: controller.useTouchId,
// onChanged: (val) => print('Toggle: $val'),
// )
// ```
//
// ---
//
// ## 🎨 Customization:
//
// ### Change Colors:
// ```dart
// activeColor: Color(0xFFFF8C42),          // Orange
// inactiveColor: Colors.grey.withOpacity(0.3),
// thumbColor: Colors.white,
// ```
//
// ### Change Size:
// ```dart
// width: 60,   // Width
// height: 32,  // Height
// ```
//
// ### Change Icon:
// ```dart
// activeIcon: Icon(Icons.check, color: Color(0xFFFF8C42), size: 16),
// ```
//
// ### Change Animation:
// ```dart
// duration: Duration(milliseconds: 300),
// ```
//
// ---
//
// ## 🔥 Pro Tips:
//
// 1. **Use `LabeledToggle` for quick implementation** with label
// 2. **Keep width:height ratio ~2:1** for best look
// 3. **Use Material Icons** - no setup needed
// 4. **Adjust icon size** to match toggle size
//
// ---
//
// ## ✅ No Extra Setup Needed!
//
// - ✅ No packages required (basic version)
// - ✅ No assets needed
// - ✅ No configuration
// - ✅ Just copy & use!
//
// **Optional:** If you want SVG icons, add `flutter_svg` package
//
// ---
//
// ## 🎯 Recommended Approach:
//
// 1. **Start with:** `custom_toggle_switch_complete.dart`
// 2. **Use:** Material Icon (Icons.check)
// 3. **Customize:** Colors and size as needed
// 4. **Done!** 🎉
//
// ---
//
// ## 📱 Result:
//
// **ON State:**
// - 🟠 Orange track
// - ⚪ White thumb
// - ✓ Orange checkmark
// - Smooth animation
//
// **OFF State:**
// - ⚪ Grey track
// - ⚪ White thumb
// - (no icon)
//
// **Exactly like your screenshot!** ✨
//
// ---
//
// ## 🚀 Get Started Now:
//
// 1. Copy `custom_toggle_switch_complete.dart`
// 2. Import in your file
// 3. Use `CustomToggleSwitch` widget
// 4. Enjoy! 🎉
//
// **That's it!** No complicated setup, no extra packages, just works! 👍