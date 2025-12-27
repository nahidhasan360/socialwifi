import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:right_routes/core/routes/all_routes.dart';
import 'package:right_routes/global_widgets/custom_navbar.dart';
import 'package:right_routes/utils/assets_manager.dart';
import 'package:right_routes/utils/colors.dart';

// ========== GetX Controller ==========
class ConfirmRouteController extends GetxController {
  final TextEditingController routeNameController = TextEditingController();

  RxString distance = '64.2 miles'.obs;

  RxList<TextEditingController> waypointControllers =
      <TextEditingController>[].obs;

  RxList<String> waypoints = <String>[
    'Your current location',
    'I-29',
    'Exit 63B',
    'I-94 W',
    'Exit 65A-B',
    'Exit 340',
  ].obs;

  RxInt selectedWaypointIndex = (-1).obs;

  @override
  void onInit() {
    super.onInit();
    routeNameController.text = 'Name Your Route';
    _initializeWaypointControllers();
  }

  void _initializeWaypointControllers() {
    waypointControllers.clear();
    for (var waypoint in waypoints) {
      final controller = TextEditingController(text: waypoint);
      waypointControllers.add(controller);
    }
  }

  void selectWaypoint(int index) {
    selectedWaypointIndex.value = index;
  }

  void addWaypointAt(int index) {
    try {
      if (index >= 0 && index < waypoints.length) {
        waypoints.insert(index + 1, '');
        final controller = TextEditingController(text: '');
        waypointControllers.insert(index + 1, controller);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to add waypoint',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void deleteSelectedWaypoint() {
    try {
      if (selectedWaypointIndex.value >= 0 &&
          selectedWaypointIndex.value < waypoints.length) {
        if (waypoints.length > 1) {
          int index = selectedWaypointIndex.value;
          waypoints.removeAt(index);
          waypointControllers[index].dispose();
          waypointControllers.removeAt(index);
          selectedWaypointIndex.value = -1;
          Get.snackbar(
            'Success',
            'Waypoint deleted',
            backgroundColor: AppColors.darkGray,
            colorText: Colors.white,
          );
        } else {
          Get.snackbar(
            'Notice',
            'You must have at least one waypoint',
            backgroundColor: AppColors.darkGray,
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar(
          'Notice',
          'Please select a waypoint first',
          backgroundColor: AppColors.darkGray,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to delete waypoint',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void updateWaypoint(int index, String value) {
    try {
      if (index >= 0 && index < waypoints.length) {
        waypoints[index] = value;
      }
    } catch (e) {
      debugPrint('Error updating waypoint: $e');
    }
  }

  void updateRouteName(String value) {
    try {
      routeNameController.text = value;
    } catch (e) {
      debugPrint('Error updating route name: $e');
    }
  }

  void updateRoute() {
    try {
      Get.snackbar(
        'Update',
        'Route updated successfully',
        backgroundColor: AppColors.darkGray,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update route',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    routeNameController.dispose();
    for (var controller in waypointControllers) {
      controller.dispose();
    }
    super.onClose();
  }
}

class EditConfirmStartYourRoute extends StatelessWidget {
  const EditConfirmStartYourRoute({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ConfirmRouteController());

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                SizedBox(height: 28),

                // ========== Scrollable Content Section ==========
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
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
                              SizedBox(height: 20),

                              // ========== Instruction Text with Info Icon ==========
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
                                      text: 'Check your waypoints. Tap the map to move pins or scroll down to edit the directions in the fields below. Tap Update to confirm changes. Tap Go to start. ',
                                    ),
                                    WidgetSpan(
                                      alignment: PlaceholderAlignment.middle,
                                      child: GestureDetector(
                                        onTap: () {
                                          FocusScope.of(context).unfocus();
                                          showConfirmRouteInfoDialog(context);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 2),
                                          child: SvgPicture.asset(
                                            "assets/icons/Question-Box-gray.svg",
                                            width: 15,
                                            height: 15,
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

                        // ========== MAP CONTAINER (FULL WIDTH) ==========
                        Container(
                          width: double.infinity,
                          height: 280,
                          child: Stack(
                            children: [
                              Image.asset(
                                'assets/images/confirm_map.png',
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Color(0xFFE8F4F8),
                                    child: Center(
                                      child: Icon(
                                        Icons.map_outlined,
                                        size: 64,
                                        color: Color(0xFF1A2332),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              Positioned(
                                top: 80,
                                left: 40,
                                child: Icon(
                                  Icons.location_pin,
                                  size: 35,
                                  color: AppColors.orange,
                                ),
                              ),
                              Positioned(
                                top: 150,
                                left: 180,
                                child: Icon(
                                  Icons.location_pin,
                                  size: 35,
                                  color: AppColors.orange,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // ========== Route Info Section (With Padding) ==========
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 22),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 20),

                              // ========== Distance, Delete Pin, Update Row ==========
                              Row(
                                children: [
                                  // Distance Display
                                  Obx(
                                        () => Text(
                                      controller.distance.value,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'Lato',
                                        fontWeight: FontWeight.w600,
                                        height: 2,
                                      ),
                                    ),
                                  ),
                                  Spacer(),

                                  // Delete Pin Button
                                  GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                      controller.deleteSelectedWaypoint();
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
                                  SizedBox(width: 70),

                                  // Update Button
                                  GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                      controller.updateRoute();
                                    },
                                    child: Container(
                                      width: 72,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: AppColors.orange,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Update',
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
                              SizedBox(height: 15),

                              // ========== Route Name Input Field (FIXED) ==========
                              Container(
                                width: double.infinity,
                                height: 57,
                                decoration: BoxDecoration(
                                  color: AppColors.medGray,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: TextField(
                                    controller: controller.routeNameController,
                                    onChanged: (value) => controller.updateRouteName(value),
                                    textAlign: TextAlign.start, // ✅ Left align
                                    style: TextStyle(
                                      color: const Color(0xFFBFBFBF),
                                      fontSize: 18,
                                      fontFamily: 'Lato',
                                      fontWeight: FontWeight.w400,
                                      height: 1.56,
                                    ),
                                    cursorColor: AppColors.white,
                                    cursorHeight: 20, // ✅ Smaller cursor
                                    textInputAction: TextInputAction.done,
                                    onSubmitted: (value) {
                                      FocusScope.of(context).unfocus();
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      focusedErrorBorder: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 0),
                                      hintText: 'Name Your Route',
                                      hintStyle: TextStyle(
                                        color: Color(0xFF8A9CA8),
                                        fontSize: 18,
                                        fontFamily: 'Lato',
                                        fontWeight: FontWeight.w400,
                                        height: 1.56,
                                      ),
                                      isDense: true, // ✅ Dense layout
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),

                              // ========== Waypoints Header ==========
                              Row(
                                children: [
                                  Text(
                                    'Waypoints',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontFamily: 'Lato',
                                      fontWeight: FontWeight.w700,
                                      height: 1.17,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                      showWaypointsInfoDialog(context);
                                    },
                                    child: SvgPicture.asset(
                                      "assets/icons/Question-Box-gray.svg",
                                      width: 20,
                                      height: 20,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),

                              // ========== DYNAMIC WAYPOINTS LIST ==========
                              Obx(() {
                                if (controller.waypoints.isEmpty) {
                                  return Text(
                                    'No waypoints added',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.5),
                                      fontSize: 16,
                                    ),
                                  );
                                }

                                return Column(
                                  children: List.generate(
                                    controller.waypoints.length,
                                        (index) {
                                      if (index >=
                                          controller
                                              .waypointControllers
                                              .length) {
                                        return SizedBox.shrink();
                                      }

                                      return Center(
                                        child: Column(
                                          children: [
                                            _buildWaypointItem(
                                              controller,
                                              index,
                                              context,
                                            ),
                                            _buildAddButton(
                                              controller,
                                              index,
                                              context,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }),

                              SizedBox(height: 12),

                              // ========== Bottom GO Button ==========
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(AppRoutes.driveRouteMap);
                                  FocusScope.of(context).unfocus();
                                  try {
                                    Get.snackbar(
                                      'Navigation',
                                      'Starting route navigation...',
                                      backgroundColor: AppColors.darkGray,
                                      colorText: Colors.white,
                                    );
                                  } catch (e) {
                                    Get.snackbar(
                                      'Error',
                                      'Failed to start navigation',
                                      backgroundColor: AppColors.darkGray,
                                      colorText: Colors.white,
                                    );
                                  }
                                },
                                child: Center(
                                  child: Container(
                                    width: 389,
                                    height: 55,
                                    decoration: BoxDecoration(
                                      color: AppColors.orange,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'GO',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontFamily: 'Bebas Neue',
                                          fontWeight: FontWeight.w400,
                                          height: 1.17,
                                          letterSpacing: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 141),
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
      ),
    );
  }

  // ========== Waypoint Item Widget ==========
  Widget _buildWaypointItem(
      ConfirmRouteController controller,
      int index,
      BuildContext context,
      ) {
    return Obx(
          () => GestureDetector(
        onTap: () {
          controller.selectWaypoint(index);
        },
        child: Container(
          margin: EdgeInsets.only(left: 30, right: 10, bottom: 3),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.medGray,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  padding: EdgeInsets.only(
                    top: 10,
                    left: 14,
                    right: 10,
                    bottom: 10,
                  ),
                  child: TextField(
                    controller: controller.waypointControllers[index],
                    onChanged: (value) =>
                        controller.updateWaypoint(index, value),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w400,
                      height: 1.75,
                    ),
                    cursorColor: AppColors.white,
                    cursorHeight: 20, // ✅ Smaller cursor
                    textInputAction: TextInputAction.done,
                    onSubmitted: (value) {
                      FocusScope.of(context).unfocus();
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  controller.selectWaypoint(index);
                  controller.deleteSelectedWaypoint();
                },
                child: SvgPicture.asset(
                  "assets/icons/Close-X-white.svg",
                  width: 30,
                  height: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ========== Add Button Between Waypoints ==========
  Widget _buildAddButton(
      ConfirmRouteController controller,
      int index,
      BuildContext context,
      ) {
    return Container(
      margin: EdgeInsets.only(bottom: 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              controller.addWaypointAt(index);
            },
            child: SvgPicture.asset(
              "assets/icons/Check-Box-gray-white-border.svg",
              width: 24,
              height: 24,
            ),
          ),
          SizedBox(width: 4),
          Container(width: 29, height: 2, color: AppColors.medGray),
          SizedBox(width: 34),
        ],
      ),
    );
  }
}

// ========== DIALOGS ==========
void showConfirmRouteInfoDialog(BuildContext context) {
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

void showWaypointsInfoDialog(BuildContext context) {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.edit_location_alt,
                    color: Colors.white,
                    size: 24,
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
                  child: Text(
                    'Tap inside a field to select a waypoint.\nTap the "+" icon to add a field.\nTap the "X" icon or "Delete Pin" button to remove selected waypoint.\nTap Update to refresh your route before clicking Go.',
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