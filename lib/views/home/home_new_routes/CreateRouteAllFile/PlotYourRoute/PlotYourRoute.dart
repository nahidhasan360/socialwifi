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
              SizedBox(height: 27),

              // ========== Scrollable Content Section ==========
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ========== Content WITH Padding ==========
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ========== Title ==========
                            Row(
                              children: [
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      'PLOT YOUR ROUTE',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
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
                            SizedBox(height: 16),

                            // ========== Instruction Text ==========
                            Text(
                              'Tap Start to begin. This will center the map',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
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
                                    fontSize: 15,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w500,
                                    height: 1.44,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                GestureDetector(
                                  onTap: () {
                                    showPlotRouteInfoDialog(context);
                                  },
                                  child: SvgPicture.asset(
                                    "assets/icons/Question-Box-gray.svg",
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),

                            // ========== Start Button ==========
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
                            SizedBox(height: 20),
                          ],
                        ),
                      ),

                      // ========== MAP CONTAINER (FULL WIDTH - NO PADDING) ==========
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
                              Image.asset(
                                'assets/images/map_image.png',
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
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

                              // Zoom controls
                              Positioned(
                                top: 10.h,
                                right: 10.w,
                                child: Column(
                                  children: [
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

                      // ========== Back Button WITH Padding ==========
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 22.w),
                        child: Column(
                          children: [
                            SizedBox(height: 20.h),
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
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      letterSpacing: 0.5,
                                    ),
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
}

// ========== DIALOG ==========
void showPlotRouteInfoDialog(BuildContext context) {
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/Vector-hand.svg",
                      width: 28,
                      height: 28,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: SvgPicture.asset(
                        "assets/icons/Close-X-Circle.svg",
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
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
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: ', the map zooms in, centers on his geo location using his device\'s GPS tracking and places a route start pin on the map at that location. ',
                      ),
                      TextSpan(
                        text: 'See screen 688',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
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