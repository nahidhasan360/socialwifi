import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/routes/all_routes.dart';

class CustomNavbar extends StatelessWidget {
  final NavController controller = Get.put(NavController());

  CustomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      height: 65,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF5A5A5A),

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          navItem(
            index: 0,
            icon: Icons.refresh_rounded,
            label: "New Route",
            route: AppRoutes.homeNewRoutes,
          ),
          navItem(
            index: 1,
            icon: Icons.group_rounded,
            label: "Teams",
            route: AppRoutes.homeNewRoutes,
          ),
          navItem(
            index: 2,
            icon: Icons.history_rounded,
            label: "History",
            route: AppRoutes.historyScreen,
          ),
          navItem(
            index: 3,
            icon: Icons.person_outline,
            label: "Account",
            route: AppRoutes.accountScreen,
          ),
        ],
      ),
    ));
  }

  Widget navItem({
    required int index,
    required IconData icon,
    required String label,
    required String route,
  }) {
    bool isSelected = controller.selectedIndex.value == index;

    return GestureDetector(
      onTap: () {
        controller.changeTab(index);
        Get.offNamed(route);   // ← Route Navigate
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 26,
            color: isSelected ? Colors.orange : Colors.white,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? Colors.orange : Colors.white,
            ),
          )
        ],
      ),
    );
  }
}


class NavController extends GetxController {
  RxInt selectedIndex = 0.obs;

  void changeTab(int index) {
    selectedIndex.value = index;
  }
}
