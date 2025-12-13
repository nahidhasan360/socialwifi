import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:right_routes/global_widgets/custom_navbar.dart';
import 'package:right_routes/utils/assets_manager.dart';
import 'package:right_routes/utils/colors.dart';

// ========== GetX Controller ==========
// Purpose: Manage dynamic waypoints list
class ConfirmRouteController extends GetxController {
  // Route name
  RxString routeName = 'Route Name'.obs;

  // Distance
  RxString distance = '64.2 miles'.obs;

  // Dynamic waypoints list
  RxList<String> waypoints = <String>[
    'Your current location',
    'I-29',
    'Exit 63B',
    'I-94 W',
    'Exit 65A-B',
    'Exit 340',
  ].obs;

  // Add new waypoint
  void addWaypoint() {
    waypoints.add('New waypoint');
  }

  // Remove waypoint at index
  void removeWaypoint(int index) {
    if (waypoints.length > 1) {  // Keep at least one waypoint
      waypoints.removeAt(index);
    }
  }

  // Update waypoint text at index
  void updateWaypoint(int index, String value) {
    waypoints[index] = value;
  }
}

class EditConfirmStartYourRoute extends StatelessWidget {
  const EditConfirmStartYourRoute({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ConfirmRouteController());

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
          child: Column(
            children: [
              // ========== Fixed Logo Section ==========
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
              SizedBox(height: 32.h),

              // ========== Scrollable Content Section ==========
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ========== Content with Padding ==========
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 22.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ========== Title (Centered) ==========
                            Row(
                              children: [
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      'CONFIRM YOUR ROUTE',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 32,
                                        fontFamily: 'League Gothic',
                                        fontWeight: FontWeight.w400,
                                        height: 0.88,
                                        letterSpacing: 1.50,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),

                            // ========== Instruction Text with Info Icon ==========
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Check your waypoints. Tap the map to move pins or scroll down to edit the directions in the fields below. Tap Update to confirm changes. Tap Go to start.',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontFamily: 'Lato',
                                      fontWeight: FontWeight.w500,
                                      height: 1.44,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                // Info Icon
                                GestureDetector(
                                  onTap: () {
                                    showConfirmRouteInfoDialog(context);
                                  },
                                  child: SvgPicture.asset(
                                    "assets/icons/Question-Box-gray.svg",
                                    width: 24.w,
                                    height: 24.h,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
                          ],
                        ),
                      ),

                      // ========== MAP CONTAINER (FULL WIDTH) ==========
                      Container(
                        width: double.infinity,
                        height: 280,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Stack(
                          children: [
                            // Map Image
                            Image.asset(
                              'assets/images/map_image.png',
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Color(0xFFE8F4F8),
                                  child: Center(
                                    child: Icon(
                                      Icons.map_outlined,
                                      size: 64.sp,
                                      color: Color(0xFF1A2332),
                                    ),
                                  ),
                                );
                              },
                            ),
                            // Example pins
                            Positioned(
                              top: 80.h,
                              left: 40.w,
                              child: Icon(Icons.location_pin, size: 35.sp, color: AppColors.orange),
                            ),
                            Positioned(
                              top: 150.h,
                              left: 180.w,
                              child: Icon(Icons.location_pin, size: 35.sp, color: AppColors.orange),
                            ),
                            Positioned(
                              top: 120.h,
                              right: 60.w,
                              child: Icon(Icons.location_pin, size: 35.sp, color: AppColors.orange),
                            ),
                          ],
                        ),
                      ),

                      // ========== Route Info and Waypoints Section (With Padding) ==========
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 22.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20.h),

                            // ========== Distance and Update Button Row ==========
                            Row(
                              children: [
                                // Distance Display
                                Obx(() => Text(
                                  controller.distance.value,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w700,
                                  ),
                                )),
                                Spacer(),
                                // Update Button
                                GestureDetector(
                                  onTap: () {
                                    // TODO: Recalculate route
                                    print('Update route');
                                  },
                                  child: Container(
                                    width: 76,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: AppColors.orange,
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Update',
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                // Go Button
                                GestureDetector(
                                  onTap: () {
                                    // TODO: Start navigation
                                    print('Start navigation');
                                  },
                                  child: Container(
                                    width: 64,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: AppColors.orange,
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Go',
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15.h),

                            // ========== Route Name Input Field ==========
                            Container(
                              width: double.infinity,
                              height: 40.h,
                              decoration: BoxDecoration(
                                color: Color(0xFF2C3E50),
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              child: TextField(
                                controller: TextEditingController(text: controller.routeName.value),
                                onChanged: (value) => controller.routeName.value = value,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.w500,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Name Your Route',
                                  hintStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.5),
                                    fontSize: 16,
                                    fontFamily: 'Lato',
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 15.h),

                            // ========== Waypoints Header with Info Icon ==========
                            Row(
                              children: [
                                Text(
                                  'Waypoints',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                GestureDetector(
                                  onTap: () {
                                    showWaypointsInfoDialog(context);
                                  },
                                  child: SvgPicture.asset(
                                    "assets/icons/Question-Box-gray.svg",
                                    width: 20.w,
                                    height: 20.h,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12.h),

                            // ========== DYNAMIC WAYPOINTS LIST ==========
                            Obx(() => Column(
                              children: List.generate(
                                controller.waypoints.length,
                                    (index) => _buildWaypointItem(
                                  context,
                                  controller,
                                  index,
                                ),
                              ),
                            )),

                            SizedBox(height: 15.h),

                            // ========== Add Waypoint Button (Full Width Orange) ==========
                            GestureDetector(
                              onTap: () => controller.addWaypoint(),
                              child: Container(
                                width: double.infinity,
                                height: 48.h,
                                decoration: BoxDecoration(
                                  color: AppColors.orange,
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 24.sp,
                                      ),
                                      SizedBox(width: 8.w),
                                      Text(
                                        'Add Waypoint',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 40.h),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavbar(),
    );
  }

  // ========== Waypoint Item Widget ==========
  // Purpose: Single editable waypoint field with drag handle and delete
  Widget _buildWaypointItem(
      BuildContext context,
      ConfirmRouteController controller,
      int index,
      ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          // ========== Drag Handle Icon ==========
          Icon(
            Icons.drag_indicator,
            color: Colors.white.withOpacity(0.5),
            size: 24.sp,
          ),
          SizedBox(width: 8.w),

          // ========== Waypoint Input Field ==========
          Expanded(
            child: Container(
              height: 40.h,
              decoration: BoxDecoration(
                color: Color(0xFF455A64),
                borderRadius: BorderRadius.circular(5.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: TextField(
                controller: TextEditingController(text: controller.waypoints[index]),
                onChanged: (value) => controller.updateWaypoint(index, value),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),

          // ========== Delete Button (X) ==========
          GestureDetector(
            onTap: () => controller.removeWaypoint(index),
            child: Container(
              width: 32.w,
              height: 32.h,
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ========== CONFIRM ROUTE INFO DIALOG ==========
void showConfirmRouteInfoDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.only(
          top: 60.h,
          bottom: 100.h,
          left: 20.w,
          right: 20.w,
        ),
        child: Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Color(0xFF4A4A4A),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Fixed Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset("assets/icons/Vector-hand.svg", width: 24, height: 24),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: SvgPicture.asset("assets/icons/Close-X-Circle.svg", width: 24, height: 24),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              // Scrollable Content
              Flexible(
                child: SingleChildScrollView(
                  child: Text(
                    'Manipulating the map:\nTo move the map, use one finger to drag it to the desired location.\nTo enlarge the map, use two fingers and spread them on the map.\nTo reduce the map, slide your two fingers together.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w500,
                      height: 1.44,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

// ========== WAYPOINTS INFO DIALOG ==========
void showWaypointsInfoDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.only(
          top: 60.h,
          bottom: 100.h,
          left: 20.w,
          right: 20.w,
        ),
        child: Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Color(0xFF4A4A4A),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Fixed Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.edit_location_alt, color: Colors.white, size: 24.sp),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: SvgPicture.asset("assets/icons/Close-X-Circle.svg", width: 24, height: 24),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              // Scrollable Content
              Flexible(
                child: SingleChildScrollView(
                  child: Text(
                    'Tap inside a field to edit a waypoint.\nTap the "+" icon to add a field.\nTap the "X" icon to remove a field.\nTap Update to refresh your route before clicking Go.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w500,
                      height: 1.44,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}