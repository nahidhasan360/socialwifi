import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:right_routes/core/routes/all_routes.dart';
import 'package:right_routes/global_widgets/custom_navbar.dart';
import 'package:right_routes/utils/assets_manager.dart';
import 'package:right_routes/utils/colors.dart';

class PlotYourRoute extends StatelessWidget {
  const PlotYourRoute({super.key});

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
          child: Column(
            children: [
              // ========== Fixed Logo Section ==========
              // Purpose: Company branding logo at top
              // Size: 225x112 (fixed)
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
              // Purpose: Main content area with map and instructions
              // Padding: 22.w horizontal
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 22.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ========== Title with Info Icon ==========
                      // Purpose: Page heading "PLOT YOUR ROUTE"
                      // Font: League Gothic, 32sp, White
                      // Layout: Title text + info icon
                      Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                'PLOT YOUR ROUTE',
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
                      // Purpose: Explain Start button functionality
                      // Font: Lato, 18sp, White
                      // Layout: Text + info icon in a row
                      Text(
                        'Tap Start to begin. This will center the map',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w500,
                          height: 1.44,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'to your current location.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w500,
                              height: 1.44,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          // ========== Info Icon Button ==========
                          // Purpose: Show map usage instructions dialog
                          GestureDetector(
                            onTap: () {
                              showPlotRouteInfoDialog(context);
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

                      // ========== Start Button ==========
                      // Purpose: Initialize map centering to user location
                      // Size: 64w x 24h
                      // Background: Orange (AppColors.orange)
                      // Border radius: 5.r
                      GestureDetector(
                        onTap: () {
                           Get.toNamed(AppRoutes.pinsMaking);
                          print('Start button tapped - Centering map...');
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
                              'Start',
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
                      SizedBox(height: 20.h),

                      // ========== Interactive Map Container ==========
                      // Purpose: Display Google Map for route plotting
                      // Design: Full width, fixed height, map background
                      // Features: Zoom, pan, place waypoints, GPS centering
                      // Height: Calculated to fit screen properly
                      Container(
                        width: double.infinity,
                        height: 383,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color: Color(0xFF1A2332),
                            width: 2.w,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Stack(
                            children: [
                              // ========== Map Placeholder ==========
                              // Purpose: Google Map will be integrated here
                              // For now: Static map image as placeholder
                              // TODO: Replace with GoogleMap widget
                              Image.asset(
                                'assets/images/map_image.png',
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  // Fallback if image not found
                                  return Container(
                                    color: Color(0xFFE8F4F8),
                                    child: Center(
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
                                            'Map View',
                                            style: TextStyle(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF1A2332),
                                            ),
                                          ),
                                          SizedBox(height: 8.h),
                                          Text(
                                            'Interactive map will appear here',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF666666),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),

                              // ========== Map Controls Overlay (Optional) ==========
                              // Purpose: Zoom in/out buttons overlay on map
                              // Position: Top-right corner
                              // Can be added for better UX
                              Positioned(
                                top: 10.h,
                                right: 10.w,
                                child: Column(
                                  children: [
                                    // Zoom In button
                                    Container(
                                      width: 36.w,
                                      height: 36.h,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(4.r),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.1),
                                            blurRadius: 4,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        size: 20.sp,
                                        color: Color(0xFF1A2332),
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    // Zoom Out button
                                    Container(
                                      width: 36.w,
                                      height: 36.h,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(4.r),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.1),
                                            blurRadius: 4,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        Icons.remove,
                                        size: 20.sp,
                                        color: Color(0xFF1A2332),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),

                      // ========== Back Button ==========
                      // Purpose: Navigate to previous screen
                      // Size: 57w x 24h
                      // Background: Orange
                      // Border radius: 5.r
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          width: 57,
                          height: 24,
                          decoration: BoxDecoration(
                            color: AppColors.orange,
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Center(
                            child: Text(
                              'Back',
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

                      SizedBox(height: 40.h), // Bottom spacing
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
}

// ========== INFO DIALOG FUNCTION ==========
// Purpose: Explain map interaction features
// Trigger: When user taps info icon (?)
// Content: Map zoom, pan, waypoint placement instructions
void showPlotRouteInfoDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        // ========== Dialog Positioning ==========
        insetPadding: EdgeInsets.only(
          top: 60.h,
          bottom: 100.h,
          left: 20.w,
          right: 20.w,
        ),
        child: Container(
          // ========== Dialog Container ==========
          // Background: Dark gray (#4A4A4A)
          // Padding: 20.w all around
          // Border radius: 12.r
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Color(0xFF4A4A4A),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ========== Header: Map Icon + Close ==========
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Map/Location icon
                    SvgPicture.asset(
                      "assets/icons/Vector-hand.svg",
                      width: 24,
                      height: 24,
                    ),

                    // ========== Close Button ==========
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: SvgPicture.asset(
                        "assets/icons/Close-X-Circle.svg",
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                // ========== Dialog Content - Paragraph 1 ==========
                // Purpose: Explain map interaction features
                // Font: Lato, 18sp, White, height 1.44
                Text(
                  'Make sure you are at the starting point of your route before tapping start because this app uses your current geo location for plotting the first waypoint.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w500,
                    height: 1.44,
                  ),
                ),
                SizedBox(height: 16.h),

                // ========== Dialog Content - Paragraph 2 ==========
                // Purpose: Explain Start button functionality
                // Font: Lato, 18sp, White, height 1.44
                // Note: Contains bold text "Start" and "See screen 688"
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w500,
                      height: 1.44,
                    ),
                    children: [
                      TextSpan(
                        text: 'When the user taps ',
                      ),
                      TextSpan(
                        text: 'Start',
                        style: TextStyle(
                          fontWeight: FontWeight.w700, // Bold
                        ),
                      ),
                      TextSpan(
                        text: ', the map zooms in, centers on his geo location using his device\'s GPS tracking and places a route start pin on the map at that location. ',
                      ),
                      TextSpan(
                        text: 'See screen 688',
                        style: TextStyle(
                          fontWeight: FontWeight.w700, // Bold
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}