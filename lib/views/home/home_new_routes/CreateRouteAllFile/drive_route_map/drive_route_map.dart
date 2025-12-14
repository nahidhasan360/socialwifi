import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:right_routes/global_widgets/custom_navbar.dart';
import 'package:right_routes/utils/assets_manager.dart';
import 'package:right_routes/utils/colors.dart';

// ========== GetX Controller ==========
// Purpose: Manage map state, vehicle position, navigation
class DriveRouteController extends GetxController {
  // Vehicle position tracking
  RxDouble vehicleLat = 0.0.obs;
  RxDouble vehicleLng = 0.0.obs;

  // Map center position
  RxDouble mapCenterLat = 0.0.obs;
  RxDouble mapCenterLng = 0.0.obs;

  // Navigation state
  RxBool isNavigating = true.obs;
  RxBool isOfflineMode = false.obs;

  // Recenter vehicle to map center
  void recenterVehicle() {
    try {
      // TODO: Implement map recentering logic
      // Center map camera to vehicle position
      mapCenterLat.value = vehicleLat.value;
      mapCenterLng.value = vehicleLng.value;

      Get.snackbar(
        'Recenter',
        'Vehicle re-centered',
        backgroundColor: AppColors.darkGray,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to recenter vehicle',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Download route for offline use
  void downloadRoute() {
    try {
      // TODO: Implement offline map download
      isOfflineMode.value = true;

      Get.snackbar(
        'Download',
        'Route downloaded for offline use',
        backgroundColor: AppColors.darkGray,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to download route',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Cancel navigation
  void cancelNavigation() {
    try {
      isNavigating.value = false;
      Get.back(); // Go back to create route screen
    } catch (e) {
      debugPrint('Error canceling navigation: $e');
    }
  }
}

class DriveRouteMap extends StatelessWidget {
  const DriveRouteMap({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DriveRouteController());

    return Scaffold(
      // ========== No resize to avoid white background ==========
      resizeToAvoidBottomInset: false,

      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: Stack(
            children: [
              // ========== FULL SCREEN MAP ==========
              // Purpose: Live navigation map showing route and vehicle
              // Features: Roads, POIs, route line, vehicle marker
              Positioned.fill(
                child: Container(
                  color: Color(0xFFE8F4F8), // Light blue background
                  child: Stack(
                    children: [
                      // ========== Map Image Placeholder ==========
                      // TODO: Replace with GoogleMap widget
                      Image.asset(
                        'assets/images/map_image.png',
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.map_outlined,
                                  size: 64.sp,
                                  color: Color(0xFF1A2332),
                                ),
                                SizedBox(height: 12.h),
                                Text(
                                  'Navigation Map',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF1A2332),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),

                      // ========== Vehicle Marker (Center) ==========
                      // Purpose: Show truck/vehicle position on map
                      // Position: Center of screen
                      Center(
                        child: Icon(
                          Icons.local_shipping,
                          size: 40.sp,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ========== TOP BUTTONS ROW ==========
              // Purpose: Navigation controls
              // Layout: Back, Download, Recenter, Cancel
              Positioned(
                top: 12.h,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // ========== Back Button ==========
                      // Function: Goes back to edit route (08f)
                      _buildTopButton(
                        text: 'Back',
                        onTap: () {
                          Get.back();
                        },
                      ),

                      // ========== Download Button ==========
                      // Function: Download route for offline use
                      _buildTopButton(
                        text: 'Download',
                        onTap: () {
                          controller.downloadRoute();
                        },
                      ),

                      // ========== Recenter Button ==========
                      // Function: Re-center vehicle to center of screen
                      _buildTopButton(
                        text: 'Recenter',
                        onTap: () {
                          controller.recenterVehicle();
                        },
                      ),

                      // ========== Cancel Button ==========
                      // Function: Goes back to create route (08)
                      _buildTopButton(
                        text: 'Cancel',
                        onTap: () {
                          controller.cancelNavigation();
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // ========== BOTTOM INFO BOX ==========
              // Purpose: Display offline mode information
              // Position: Above bottom navbar
              Positioned(
                bottom: 70.h, // Above navbar
                left: 12.w,
                right: 12.w,
                child: Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(8.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    'Automatically sets the map code to convert to offline use if the user drives into an area with no cell service. See PDF docs in our package for info on this.',
                    style: TextStyle(
                      color: Color(0xFF1A1A1A),
                      fontSize: 13.sp,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // ========== BOTTOM NAVBAR ==========
      // Icons: New Route, Team, History, Account
      bottomNavigationBar: CustomNavbar(),
    );
  }

  // ========== Top Button Widget ==========
  // Purpose: Reusable orange button for top controls
  // Size: Auto width, 32.h height
  Widget _buildTopButton({
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 6.h,
        ),
        decoration: BoxDecoration(
          color: AppColors.orange,
          borderRadius: BorderRadius.circular(5.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }
}