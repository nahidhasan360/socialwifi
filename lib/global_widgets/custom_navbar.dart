// custom_navbar.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../core/routes/all_routes.dart';

class CustomNavbar extends StatefulWidget {
  const CustomNavbar({super.key});

  @override
  State<CustomNavbar> createState() => _CustomNavbarState();
}

class _CustomNavbarState extends State<CustomNavbar> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavController(), permanent: true);

    // ✅ Update navbar on every build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.updateFromCurrentRoute();
    });

    return GetBuilder<NavController>(
      id: 'navbar',
      builder: (controller) {
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
        if (Get.currentRoute == route) return;

        controller.changeTab(index);
        Get.offAllNamed(route);
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
  final List<String> _routeHistory = [];

  final Map<String, int> _routeToIndex = {
    AppRoutes.homeNewRoutes: 0,
    AppRoutes.teamManager: 1,
    AppRoutes.historyScreen: 2,
    AppRoutes.accountScreen: 3,
  };

  void changeTab(int index) {
    selectedIndex.value = index;
    update(['navbar']);
  }

  void saveCurrentNavbarRoute() {
    String currentRoute = Get.currentRoute;
    if (_routeToIndex.containsKey(currentRoute)) {
      _routeHistory.clear();
      _routeHistory.add(currentRoute);
    }
  }

  void updateFromCurrentRoute() {
    String currentRoute = Get.currentRoute;

    if (_routeToIndex.containsKey(currentRoute)) {
      int index = _routeToIndex[currentRoute]!;
      if (selectedIndex.value != index) {
        selectedIndex.value = index;
        update(['navbar']);
      }
      if (_routeHistory.isEmpty || _routeHistory.last != currentRoute) {
        _routeHistory.clear();
        _routeHistory.add(currentRoute);
      }
    } else if (_routeHistory.isNotEmpty) {
      String lastNavbarRoute = _routeHistory.last;
      int index = _routeToIndex[lastNavbarRoute]!;
      if (selectedIndex.value != index) {
        selectedIndex.value = index;
        update(['navbar']);
      }
    }
  }
}