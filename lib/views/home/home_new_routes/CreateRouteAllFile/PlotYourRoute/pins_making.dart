import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:right_routes/core/routes/all_routes.dart';
import 'package:right_routes/global_widgets/custom_navbar.dart';
import 'package:right_routes/utils/assets_manager.dart';
import 'package:right_routes/utils/colors.dart';

// ========== PIN MODEL ==========
class PinModel {
  String id;
  Offset position;
  bool isActive; // burgundy when true, orange when false

  PinModel({
    required this.id,
    required this.position,
    this.isActive = false,
  });
}

// ========== CONTROLLER ==========
class PinsMakingController extends GetxController {
  var pins = <PinModel>[].obs;
  Rxn<String> selectedPinId = Rxn<String>();

  // Add initial sample pins
  @override
  void onInit() {
    super.onInit();
    // Add sample pins
    pins.add(PinModel(
      id: 'pin_1',
      position: Offset(150, 100),
      isActive: false,
    ));
    pins.add(PinModel(
      id: 'pin_2',
      position: Offset(130, 180),
      isActive: false,
    ));
  }

  // ✅ Add new pin at map center (burgundy/active)
  void addPin() {
    final newPin = PinModel(
      id: 'pin_${DateTime.now().millisecondsSinceEpoch}',
      position: Offset(175, 191.5), // Center of 383px height map
      isActive: true, // Burgundy color (movable)
    );

    // Deactivate all other pins
    for (var pin in pins) {
      pin.isActive = false;
    }

    pins.add(newPin);
    selectedPinId.value = newPin.id;

    Get.snackbar(
      'Pin Added',
      'Burgundy pin added at center. Hold and drag to move.',
      backgroundColor: Colors.green.withOpacity(0.8),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 2),
    );
  }

  // ✅ Set all pins to orange (tap on map)
  void setAllPinsOrange() {
    for (var pin in pins) {
      pin.isActive = false;
    }
    selectedPinId.value = null;
    pins.refresh();
  }

  // ✅ Select pin (make burgundy/active)
  void selectPin(String pinId) {
    // Deactivate all pins
    for (var pin in pins) {
      pin.isActive = false;
    }

    // Activate selected pin
    final selectedPin = pins.firstWhere((p) => p.id == pinId);
    selectedPin.isActive = true;
    selectedPinId.value = pinId;

    pins.refresh();
  }

  // ✅ Move pin
  void movePin(String pinId, Offset newPosition) {
    final pin = pins.firstWhere((p) => p.id == pinId);
    pin.position = newPosition;
    pins.refresh();
  }

  // ✅ Delete selected pin
  void deleteSelectedPin() {
    if (selectedPinId.value == null) {
      Get.snackbar(
        'No Pin Selected',
        'Please tap on a pin to select it first',
        backgroundColor: Colors.orange.withOpacity(0.8),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 2),
      );
      return;
    }

    pins.removeWhere((pin) => pin.id == selectedPinId.value);
    selectedPinId.value = null;

    Get.snackbar(
      'Pin Deleted',
      'Selected pin removed',
      backgroundColor: Colors.red.withOpacity(0.8),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 2),
    );
  }
}

// ========== MAIN SCREEN ==========
class PinsMaking extends StatelessWidget {
  const PinsMaking({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PinsMakingController());

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

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                    text: 'Tap the ',
                                  ),
                                  WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    child: GestureDetector(
                                      onTap: () {
                                        showPlotRouteInfoDialog(context);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 4),
                                        child: SvgPicture.asset(
                                          "assets/icons/Question-Box-gray.svg",
                                          width: 20,
                                          height: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'icon for directions.',
                                  ),
                                ],
                              ),
                            ),

                            // RichText(
                            //   text: TextSpan(
                            //     style: TextStyle(
                            //       color: Colors.white,
                            //       fontSize: 18,
                            //       fontFamily: 'Lato',
                            //       fontWeight: FontWeight.w500,
                            //       height: 1.44,
                            //     ),
                            //     children: [
                            //       TextSpan(
                            //         text: 'Tap to place a pins marking your waypoints.\nSelect a pin and tap Delete to remove.\nWhen done, tap Continue. ',
                            //       ),
                            //       WidgetSpan(
                            //         alignment: PlaceholderAlignment.middle,
                            //         child: GestureDetector(
                            //           onTap: () {
                            //             showPlotRouteInfoDialog(context);
                            //           },
                            //           child: Padding(
                            //             padding: const EdgeInsets.only(left: 4),
                            //             child: SvgPicture.asset(
                            //               "assets/icons/Question-Box-gray.svg",
                            //               width: 20,
                            //               height: 20,
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),

                      // ✅ MAP CONTAINER WITH TAP & DRAG
                      GestureDetector(
                        onTapDown: (details) {
                          // ✅ Tap on map - set all pins to orange
                          controller.setAllPinsOrange();
                        },
                        child: Container(
                          width: double.infinity,
                          height: 383,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Stack(
                            children: [
                              // Map Image
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

                              // ✅ DYNAMIC PINS
                              Obx(() => Stack(
                                children: controller.pins.map((pin) {
                                  return Positioned(
                                    left: pin.position.dx,
                                    top: pin.position.dy,
                                    child: GestureDetector(
                                      onTapDown: (details) {
                                        // ✅ Select pin (make burgundy)
                                        controller.selectPin(pin.id);
                                      },
                                      onPanUpdate: (details) {
                                        // ✅ Move pin if active
                                        if (pin.isActive) {
                                          controller.movePin(
                                            pin.id,
                                            Offset(
                                              (pin.position.dx + details.delta.dx).clamp(0.0, 350.0),
                                              (pin.position.dy + details.delta.dy).clamp(0.0, 343.0),
                                            ),
                                          );
                                        }
                                      },
                                      child: Icon(
                                        Icons.location_pin,
                                        size: 40,
                                        color: pin.isActive
                                            ? Color(0xFF800020) // Burgundy
                                            : AppColors.orange,  // Orange
                                      ),
                                    ),
                                  );
                                }).toList(),
                              )),

                              // Map Controls
                              Positioned(
                                top: 10,
                                right: 10,
                                child: Column(
                                  children: [
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
                      ),

                      // ✅ UPDATED: 4 BUTTONS (Back, Add Pin, Delete Pin, Continue)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 22),
                        child: Column(
                          children: [
                            SizedBox(height: 20),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Back Button
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

                                // ✅ NEW: Add Pin Button
                                GestureDetector(
                                  onTap: () {
                                    controller.addPin();
                                  },
                                  child: Container(
                                    width: 75,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: AppColors.orange,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Add Pin',
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

                                // Delete Pin Button
                                GestureDetector(
                                  onTap: () {
                                    controller.deleteSelectedPin();
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

                                // Continue Button
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.editConfirmStartYourRoute);
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

// ========== INFO DIALOG ==========
// ========== INFO DIALOG - UPDATED TEXT ==========
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
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Color(0xFF4A4A4A),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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

              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // ✅ COMPLETELY UPDATED TEXT
                      Text.rich(
                        TextSpan(
                          children: [
                            // Section 1: Current Location
                            TextSpan(
                              text: 'The pin shown is your current location.\n',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w700,
                                height: 1.44,
                              ),
                            ),

                            // Section 2: Placing Pins
                            TextSpan(
                              text: 'Placing pins:\n ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w700,
                                height: 1.44,
                              ),
                            ),
                            TextSpan(
                              text: 'Tap the Add Pin button then drag the new pin to a location on your route. This will create a waypoint. Keep placing pins at entrances, exits and turns until you reach your destination.\n',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w500,
                                height: 1.44,
                              ),
                            ),

                            // Section 3: Deleting Pins
                            TextSpan(
                              text: 'Deleting pins:\n ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w700,
                                height: 1.44,
                              ),
                            ),
                            TextSpan(
                              text: 'Tap a pin to select it. It will turn burgundy. Tap the Delete Pin button.\n',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w500,
                                height: 1.44,
                              ),
                            ),

                            // Section 4: Manipulating the Map
                            TextSpan(
                              text: 'Manipulating the map:\n',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w700,
                                height: 1.44,
                              ),
                            ),
                            TextSpan(
                              text: 'Use one finger to move the map within the window. Spread or contract two fingers on the map the zoom in or out.\n',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w500,
                                height: 1.44,
                              ),
                            ),

                            // Section 5: Continue
                            TextSpan(
                              text: 'Tap Continue which will take you to the edit route screen to refine your waypoints.',
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