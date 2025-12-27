import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:right_routes/core/routes/all_routes.dart';
import 'package:right_routes/global_widgets/custom_navbar.dart';
import 'package:right_routes/utils/assets_manager.dart';
import 'package:right_routes/utils/colors.dart';

class PinsMaking extends StatelessWidget {
  const PinsMaking({super.key});

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
              SizedBox(height: 29),

              // ========== Scrollable Content Section ==========
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ========== Content with Padding ==========
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ========== Title (Centered) ==========
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
                            SizedBox(height: 16),

                            // ========== Instruction Text Line 1 ==========
                            // ========== Instruction Text with Info Icon (RichText) ==========
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
                                    text: 'Tap to place a pins marking your waypoints.\nSelect a pin and tap Delete to remove.\nWhen done, tap Continue. ',
                                  ),
                                  WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    child: GestureDetector(
                                      onTap: () {
                                        showPlotRouteInfoDialog(context);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 4),
                                        child: SvgPicture.asset(
                                          "assets/icons/Question-Box-gray.svg",
                                          width: 20,
                                          height: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
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
                        ),
                        child: Stack(
                          children: [
                            // ========== Map Image/Widget ==========
                            Image.asset(
                              'assets/images/map_pic.png',
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
                                          size: 64,
                                          color: Color(0xFF1A2332),
                                        ),
                                        SizedBox(height: 12),
                                        Text(
                                          'Map View',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF1A2332),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          'Tap to place waypoint pins',
                                          style: TextStyle(
                                            fontSize: 14,
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

                            // ========== Waypoint Pins (Example Markers) ==========
                            Positioned(
                              top: 100,
                              left: 150,
                              child: Icon(
                                Icons.location_pin,
                                size: 40,
                                color: AppColors.orange,
                              ),
                            ),
                            Positioned(
                              top: 180,
                              left: 130,
                              child: Icon(
                                Icons.location_pin,
                                size: 40,
                                color: AppColors.orange,
                              ),
                            ),

                            // ========== Map Controls Overlay ==========
                            Positioned(
                              top: 10,
                              right: 10,
                              child: Column(
                                children: [
                                  // Zoom In button
                                  Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(4),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(alpha: 0.1),
                                          blurRadius: 4,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      size: 20,
                                      color: Color(0xFF1A2332),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  // Zoom Out button
                                  Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(4),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(alpha: 0.1),
                                          blurRadius: 4,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      Icons.remove,
                                      size: 20,
                                      color: Color(0xFF1A2332),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ========== Bottom Buttons with Padding ==========
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 22),
                        child: Column(
                          children: [
                            SizedBox(height: 20),

                            // ========== Action Buttons Row ==========
                            Row(
                              children: [
                                // ========== Back Button ==========
                                GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Container(
                                    width: 57,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: AppColors.orange,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Back',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                Spacer(),

                                // ========== Delete Pin Button ==========
                                GestureDetector(
                                  onTap: () {
                                    print('Delete Pin tapped');
                                  },
                                  child: Container(
                                    width: 88,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: AppColors.orange,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Delete Pin',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                Spacer(),

                                // ========== Continue Button ==========
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.editConfirmStartYourRoute);
                                    print('Continue tapped');
                                  },
                                  child: Container(
                                    width: 76,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: AppColors.orange,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Continue',
                                        style: TextStyle(
                                          fontSize: 15,
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

                            SizedBox(height: 40),
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

// ========== INFO DIALOG FUNCTION ==========
void showPlotRouteInfoDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.only(
          top: 60,
          bottom: 100,
          left: 20,
          right: 20,
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Color(0xFF4A4A4A),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ========== FIXED HEADER ROW ==========
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    "assets/icons/Vector-hand.svg",
                    width: 24,
                    height: 24,
                  ),
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
              SizedBox(height: 16),

              // ========== SCROLLABLE CONTENT ==========
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // ========== Dialog Main Content ==========
                      Text.rich(
                        TextSpan(
                          children: [
                            // ========== Section 1: Pin Location ==========
                            TextSpan(
                              text: 'The pin shown is your current location.\nPlacing, moving and deleting pins:\n',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w800,
                                height: 1.44,
                              ),
                            ),
                            TextSpan(
                              text: 'Tap anywhere on the map to create a pin. It is red when active. Hold your finger on it to move to desired or tap Delete to remove it.\n',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w500,
                                height: 1.44,
                              ),
                            ),

                            // ========== Section 2: Map Manipulation ==========
                            TextSpan(
                              text: 'Manipulating the map:\n',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w800,
                                height: 1.44,
                              ),
                            ),
                            TextSpan(
                              text: 'To move the map, use one finger to drag it to the desired location.\nTo enlarge the map, use two fingers and spread them outward on the map.\nTo reduce the map, slide your two fingers together.\n',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w500,
                                height: 1.44,
                              ),
                            ),

                            // ========== Section 3: Next Step ==========
                            TextSpan(
                              text: 'The next step:\n',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w800,
                                height: 1.44,
                              ),
                            ),
                            TextSpan(
                              text: 'You will be able to refine your coordinates in the next step before beginning your route. \nTo start over again, tap the Back button.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w500,
                                height: 1.44,
                              ),
                            ),
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
      );
    },
  );
}