import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../core/routes/all_routes.dart';

class CustomNavbar extends StatelessWidget {
  CustomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavController(), permanent: true);

    return GetBuilder<NavController>(
      builder: (controller) {
        // ✅ Check current route and schedule update if needed
        WidgetsBinding.instance.addPostFrameCallback((_) {
          String currentRoute = Get.currentRoute;
          if (controller._routeToIndex.containsKey(currentRoute)) {
            int expectedIndex = controller._routeToIndex[currentRoute]!;
            if (controller.selectedIndex.value != expectedIndex) {
              controller.selectedIndex.value = expectedIndex;
              controller.update();
            }
          }
        });

        return Container(
          height: 65,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF5A5A5A),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _navItem(
                controller: controller,
                index: 0,
                svgIcon: "assets/icons/New-Route-white.svg",
                label: "New Route",
                route: AppRoutes.homeNewRoutes,
              ),
              _navItem(
                controller: controller,
                index: 1,
                svgIcon: "assets/icons/team_white.svg",
                label: "Teams",
                route: AppRoutes.teamManager,
              ),
              _navItem(
                controller: controller,
                index: 2,
                svgIcon: "assets/icons/History-white.svg",
                label: "History",
                route: AppRoutes.historyScreen,
              ),
              _navItem(
                controller: controller,
                index: 3,
                svgIcon: "assets/icons/Account-white.svg",
                label: "Account",
                route: AppRoutes.accountScreen,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _navItem({
    required NavController controller,
    required int index,
    required String svgIcon,
    required String label,
    required String route,
  }) {
    bool isSelected = controller.selectedIndex.value == index;

    return GestureDetector(
      onTap: () {
        controller.changeTab(index);
        Get.offNamed(route);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              svgIcon,
              width: 26,
              height: 26,
              colorFilter: ColorFilter.mode(
                isSelected ? Color(0xFFFF8742) : Colors.white,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? Color(0xFFFF8742) : Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NavController extends GetxController {
  RxInt selectedIndex = 0.obs;

  // ✅ Public for access in widget
  final Map<String, int> _routeToIndex = {
    AppRoutes.homeNewRoutes: 0,
    AppRoutes.teamManager: 1,
    AppRoutes.historyScreen: 2,
    AppRoutes.accountScreen: 3,
  };

  void changeTab(int index) {
    selectedIndex.value = index;
    update();
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import '../core/routes/all_routes.dart';
//
// class CustomNavbar extends StatelessWidget {
//   CustomNavbar({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // ✅ Initialize controller once
//     Get.put(NavController(), permanent: true);
//
//     // ✅ Use GetBuilder instead of Obx
//     return GetBuilder<NavController>(
//       builder: (controller) {
//         return Container(
//           height: 65,
//           width: double.infinity,
//           decoration: BoxDecoration(
//             color: const Color(0xFF5A5A5A),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               _navItem(
//                 controller: controller,
//                 index: 0,
//                 svgIcon: "assets/icons/New-Route-white.svg", // Your SVG path
//                 label: "New Route",
//                 route: AppRoutes.homeNewRoutes,
//               ),
//               _navItem(
//                 controller: controller,
//                 index: 1,
//                 svgIcon: "assets/icons/team_white.svg", // Your SVG path
//                 label: "Teams",
//                 route: AppRoutes.teamManager,
//               ),
//               _navItem(
//                 controller: controller,
//                 index: 2,
//                 svgIcon: "assets/icons/History-white.svg", // Your SVG path
//                 label: "History",
//                 route: AppRoutes.historyScreen,
//               ),
//               _navItem(
//                 controller: controller,
//                 index: 3,
//                 svgIcon: "assets/icons/Account-white.svg", // Your SVG path
//                 label: "Account",
//                 route: AppRoutes.accountScreen,
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _navItem({
//     required NavController controller,
//     required int index,
//     required String svgIcon,
//     required String label,
//     required String route,
//   }) {
//     bool isSelected = controller.selectedIndex.value == index;
//
//     return GestureDetector(
//       onTap: () {
//         controller.changeTab(index);
//         Get.offNamed(route);
//       },
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SvgPicture.asset(
//               svgIcon,
//               width: 26,
//               height: 26,
//               colorFilter: ColorFilter.mode(
//                 isSelected ? Color(0xFFFF8742) : Colors.white,
//                 BlendMode.srcIn,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               label,
//               style: TextStyle(
//                 fontSize: 12,
//                 fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
//                 color: isSelected ? Color(0xFFFF8742) : Colors.white,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class NavController extends GetxController {
//   RxInt selectedIndex = 0.obs;
//
//   void changeTab(int index) {
//     selectedIndex.value = index;
//     update(); // ✅ This triggers GetBuilder rebuild
//   }
// }
