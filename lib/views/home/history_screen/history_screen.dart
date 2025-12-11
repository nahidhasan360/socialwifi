import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:right_routes/global_widgets/custom_navbar.dart';
import 'package:right_routes/utils/assets_manager.dart';
import 'package:right_routes/utils/colors.dart';

/// ---------------------------------------------------------------------------
/// CONTROLLER (GetX)
/// ---------------------------------------------------------------------------
class HistoryController extends GetxController {
  RxString searchQuery = "".obs;
  RxBool selectAll = false.obs;

  // List of route items with selection state
  RxList<RouteItem> routes = <RouteItem>[
    RouteItem(
      id: "001",
      date: "05/26/2025",
      title: "Aurora Wind Farm in Tygard",
      isSelected: false.obs,
    ),
    RouteItem(
      id: "002",
      date: "06/04/2025",
      title: "Badger Wind Farm in Logan",
      isSelected: false.obs,
    ),
    RouteItem(
      id: "003",
      date: "06/12/2025",
      title: "Propane Tanks Downtown Fargo",
      isSelected: false.obs,
    ),
    RouteItem(
      id: "004",
      date: "06/21/2025",
      title: "Beethoven Wind SD",
      isSelected: false.obs,
      highlighted: true,
    ),
    RouteItem(
      id: "005",
      date: "07/15/2025",
      title: "Crane move in Dallas",
      isSelected: false.obs,
    ),
    RouteItem(
      id: "006",
      date: "08/28/2025",
      title: "Equipment Transport",
      isSelected: false.obs,
    ),
  ].obs;

  void updateSearch(String value) {
    searchQuery.value = value;
  }

  // Toggle select all checkbox
  void toggleSelectAll() {
    selectAll.value = !selectAll.value;
    for (var route in routes) {
      route.isSelected.value = selectAll.value;
    }
  }

  // Toggle individual route selection
  void toggleRoute(int index) {
    routes[index].isSelected.value = !routes[index].isSelected.value;

    // Update select all if all items are selected
    selectAll.value = routes.every((route) => route.isSelected.value);
  }

  // Delete selected routes
  void deleteSelected() {
    final selectedCount = routes.where((route) => route.isSelected.value).length;

    if (selectedCount == 0) {
      Get.snackbar(
        'No Selection',
        'Please select routes to delete',
        backgroundColor: Colors.red.shade400,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
      );
      return;
    }

    Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.darkGray,

        // 👉 BORDER RADIUS CONTROL
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),

        title: Text('Delete Routes', style: TextStyle(color: Colors.white)),
        content: Text(
          'Are you sure you want to delete $selectedCount route(s)?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel',style: TextStyle(fontWeight: FontWeight.bold,color:AppColors.white.withValues(alpha: 90)),),
          ),
          TextButton(
            onPressed: () {
              routes.removeWhere((route) => route.isSelected.value);
              selectAll.value = false;
              Get.back();
              Get.snackbar(
                'Success',
                'Routes deleted successfully',
                backgroundColor: Colors.green.shade400,
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            child: Text('Delete', style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
          ),
        ],
      ),
    );

  }



  // Duplicate selected route (only one at a time)
  void duplicateSelected() {
    final selectedRoutes = routes.where((route) => route.isSelected.value).toList();

    if (selectedRoutes.isEmpty) {
      Get.snackbar(
        'No Selection',
        'Please select a route to duplicate',
        backgroundColor: Colors.orange.shade400,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
      );
      return;
    }

    if (selectedRoutes.length > 1) {
      // Show error dialog - can only duplicate one route at a time
      Get.dialog(
        AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // dialog round
          ),
          backgroundColor: AppColors.darkGray,
          title: Row(
            children: [
              Icon(Icons.warning, color: Colors.white),
              SizedBox(width: 8),
              Text('Error', style: TextStyle(color: Colors.white)),
            ],
          ),
          content: Text(
            'You can only duplicate one route at a time. Please check one only.',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text('OK', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );
      return;
    }

    // Duplicate the selected route
    final routeToDuplicate = selectedRoutes.first;
    final newRoute = RouteItem(
      id: "${int.parse(routeToDuplicate.id) + 100}",
      date: routeToDuplicate.date,
      title: "${routeToDuplicate.title} (Copy)",
      isSelected: false.obs,
      highlighted: false,
    );

    routes.add(newRoute);

    // Get.snackbar(
    //   'Success',
    //   'Route duplicated successfully',
    //   backgroundColor: Colors.green.shade400,
    //   colorText: Colors.white,
    //   snackPosition: SnackPosition.BOTTOM,
    // );
  }

  // Cancel - Clear all selections and reset highlighted route
  void cancel() {
    for (var route in routes) {
      route.isSelected.value = false;
      route.highlighted = false;
    }
    selectAll.value = false;

    Get.snackbar(
      'Cancelled',
      'All selections cleared',
      backgroundColor: Colors.grey.shade600,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 1),
    );
  }

  // Search and highlight matching routes
  void searchRoutes() {
    if (searchQuery.value.isEmpty) {
      // Clear all highlights
      for (var route in routes) {
        route.highlighted = false;
      }
      return;
    }

    bool foundMatch = false;

    for (var route in routes) {
      final searchLower = searchQuery.value.toLowerCase();
      final matchesId = route.id.toLowerCase().contains(searchLower);
      final matchesDate = route.date.toLowerCase().contains(searchLower);
      final matchesTitle = route.title.toLowerCase().contains(searchLower);

      if (matchesId || matchesDate || matchesTitle) {
        route.highlighted = true;
        foundMatch = true;
      } else {
        route.highlighted = false;
      }
    }

    if (!foundMatch) {
      Get.snackbar(
        'No Results',
        'No routes found matching "${searchQuery.value}"',
        backgroundColor: Colors.orange.shade400,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Open route details
  void openRouteDetails(int index) {
    final route = routes[index];

    Get.dialog(
      AlertDialog(
        title: Text('Route Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${route.id}', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Date: ${route.date}'),
            SizedBox(height: 8),
            Text('Title: ${route.title}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Close'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              Get.toNamed('/route-edit', arguments: route);
            },
            child: Text('Edit Route'),
          ),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// ROUTE ITEM MODEL
/// ---------------------------------------------------------------------------
class RouteItem {
  final String id;
  final String date;
  final String title;
  final RxBool isSelected;
  bool highlighted;

  RouteItem({
    required this.id,
    required this.date,
    required this.title,
    required this.isSelected,
    this.highlighted = false,
  });
}

/// ---------------------------------------------------------------------------
/// MAIN SCREEN
/// ---------------------------------------------------------------------------
class HistoryScreen extends StatelessWidget {
  HistoryScreen({super.key});

  final controller = Get.put(HistoryController());
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageManager.mapBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(22.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                /// -------------------------------------------------------------------
                /// LOGO
                /// -------------------------------------------------------------------
                Center(
                  child: Container(
                    width: 225,
                    height: 112,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(ImageManager.splashScreenLogo),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 18.h),

                /// -------------------------------------------------------------------
                /// Title (without checkbox)
                /// -------------------------------------------------------------------
                Text(
                  "My Routes History",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 22.h),

                /// -------------------------------------------------------------------
                /// ACTION BUTTONS with Select All Checkbox
                /// -------------------------------------------------------------------
                Row(
                  children: [
                    // Select All Checkbox
                    Obx(() => GestureDetector(
                      onTap: controller.toggleSelectAll,
                      child: Container(
                        width: 24.w,
                        height: 24.w,
                        decoration: BoxDecoration(
                          color: controller.selectAll.value
                              ? Color(0xFFFF6B35)
                              : Colors.transparent,
                          border: Border.all(
                            color: controller.selectAll.value
                                ? Color(0xFFFF6B35)
                                : Colors.white.withOpacity(0.5),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: controller.selectAll.value
                            ? Icon(Icons.check, color: Colors.white, size: 16.sp)
                            : null,
                      ),
                    )),

                    SizedBox(width: 12.w),

                    // Action Buttons - Use Wrap for better spacing and alignment control
                    // Changed Row to Wrap to keep buttons together and aligned.
                    Wrap(
                      spacing: 8.w, // Horizontal space between buttons
                      runSpacing: 4.h, // Vertical space if buttons wrap
                      alignment: WrapAlignment.start, // Align buttons to the start
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        _smallButton("Delete", onTap: controller.deleteSelected),
                        _smallButton("Duplicate", onTap: controller.duplicateSelected),
                        _smallButton("Cancel", onTap: controller.cancel),
                        _smallButton("Exit", onTap: () => Get.back()),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 15.h),
                Divider( color: AppColors.white, thickness: 1,),
                SizedBox(height: 5.h),

                /// -------------------------------------------------------------------
                /// SEARCH BAR
                /// -------------------------------------------------------------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 38.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                      ),
                      child: Icon(Icons.search, color: Colors.white, size: 24.sp),
                    ),

                    SizedBox(width: 1.w),
                    Container(
                      height: 25,
                      width: 195,
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      decoration: BoxDecoration(
                        color: AppColors.medGray,
                        borderRadius: BorderRadius.circular(3.r),
                      ),
                      // Added contentPadding to center the text vertically
                      child: TextField(
                        controller: searchController,
                        style: TextStyle(color: Colors.white, fontSize: 14.sp),
                        cursorColor:Colors.white,
                        cursorWidth: 1.2,
                        textAlign: TextAlign.start, // Input text alignment
                        decoration: InputDecoration(
                          hintText: "Beethoven",
                          // Added alignment property to center the hint text
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w500,
                            height: 2.29,
                          ),
                          border: InputBorder.none,
                          // Set content padding to vertically center text
                          contentPadding: EdgeInsets.symmetric(vertical: 7,),
                        ),
                        onChanged: controller.updateSearch,
                      ),
                    ),
                    SizedBox(width: 3.w),

                    GestureDetector(
                      onTap: controller.searchRoutes,
                      child: Container(
                        alignment: Alignment.center,
                        height: 25,
                        width: 50.w,
                        decoration: BoxDecoration(
                          color: AppColors.medGray,
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                        child: Text(
                          "GO",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w700,
                            height: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 19.h),

                /// -------------------------------------------------------------------
                /// ROUTE LIST
                /// -------------------------------------------------------------------
                Expanded(
                  child: Obx(() => ListView.builder(
                    itemCount: controller.routes.length,
                    itemBuilder: (context, index) => _routeItem(index),
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomNavbar(),
    );
  }

  /// ---------------------------------------------------------------------------
  /// SMALL BUTTON
  /// ---------------------------------------------------------------------------
  Widget _smallButton(String text, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 28.h, // Adjusted height for better visibility
        width: 72.w, // Adjusted width for better visibility
        alignment: Alignment.center, // Center the text within the container
        padding: EdgeInsets.zero, // Removed unnecessary padding
        decoration: BoxDecoration(
          color: AppColors.orange,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp, // Adjusted font size
            fontFamily: 'Lato',
            fontWeight: FontWeight.w800,
            // Removed height property to rely on container alignment
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  /// ---------------------------------------------------------------------------
  /// ROUTE ITEM
  /// ---------------------------------------------------------------------------
  Widget _routeItem(int index) {
    final route = controller.routes[index];

    return Obx(() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
            decoration: BoxDecoration(
              color: route.isSelected.value
                  ? Color(0xFF3A4A6B).withOpacity(0.3)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Checkbox
                GestureDetector(
                  onTap: () => controller.toggleRoute(index),
                  child: Container(
                    width: 24.w,
                    height: 24.w,
                    decoration: BoxDecoration(
                      color: route.isSelected.value
                          ? Color(0xFFFF6B35)
                          : AppColors.medGray,
                      border: Border.all(
                        color: route.isSelected.value
                            ? Color(0xFFFF6B35)
                            : Colors.transparent,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: route.isSelected.value
                        ? Icon(Icons.check, color: Colors.white, size: 14.sp)
                        : null,
                  ),
                ),

                SizedBox(width: 12.w),

                /// Route Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${route.id} ${route.date}",
                        style: TextStyle(
                          color: route.highlighted
                              ? Color(0xFFFF6B35)
                              : Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        route.title,
                        style: TextStyle(
                          color: route.highlighted
                              ? Color(0xFFFF6B35).withOpacity(0.8)
                              : Colors.white70,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),

                /// Arrow Button
                GestureDetector(
                  onTap: () => controller.openRouteDetails(index),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: route.highlighted
                        ? Colors.white
                        : AppColors.white,
                    size: 24.sp,
                  ),
                ),
              ],
            ),
          ),

          /// Divider
          if (index < controller.routes.length - 1)
            Divider(
              color:AppColors.dividerColor ,
              thickness: 1,
              height: 1,
            ),
        ],
      );
    });
  }
}