import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:right_routes/core/routes/all_routes.dart';
import 'package:right_routes/views/home/home_all_widgets/dialog/dialog_document.dart';
import 'package:right_routes/views/home/home_all_widgets/dialog/dialog_map.dart';
import '../../../global_widgets/custom_navbar.dart';
import '../../../utils/assets_manager.dart';
import '../home_all_widgets/dialog/dialog_camera.dart';
import '../home_all_widgets/dialog/dialog_direction.dart';
import '../home_all_widgets/dialog/dialog_read_in_direction.dart';
import '../home_all_widgets/home_custom_button_.dart';

class HomeNewRoutes extends StatelessWidget {
  const HomeNewRoutes({super.key});

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

        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 40),

                /// Logo
                Container(
                  width: 225,
                  height: 112,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(ImageManager.splashScreenLogo),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(height: 29),
                Text(
                  'CREATE A ROUTE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontFamily: 'League Gothic',
                    fontWeight: FontWeight.w400,
                    height: 0.88,
                    letterSpacing: 1.50,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 363,
                  child: Text(
                    'Choose your preferred method of inputting\nyour route directions.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w500,
                      height: 1.44,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                SimpleImportButton(
                  text: "IMPORT DOCUMENT",
                  onTap: () {
                    Get.toNamed(AppRoutes.importYourPermit);
                  },
                  leftIcon: "assets/icons/Import_white.svg",
                  rightIcon: 'assets/images/question.png',
                  onTab: () => showPermitDialog(context),
                ),
                SizedBox(height: 13),
                SimpleImportButton(
                  text: "iMPORT DOC IMAGE",
                  onTap: () {
                    Get.toNamed(AppRoutes.importYourPhotoPermit);
                  },
                  leftIcon: "assets/icons/Camera-white.svg",
                  rightIcon: 'assets/images/question.png',
                  onTab: () => dialogCamera(context),
                ),
                SizedBox(height: 13),
                SimpleImportButton(
                  text: "TYPE IN DIRECTIONS",
                  onTap: () {
                    Get.toNamed(AppRoutes.enterDirections);
                  },
                  leftIcon: "assets/icons/Edit-Pencil-white.svg",
                  rightIcon: 'assets/images/question.png',
                  onTab: () => dialogDirection(context),
                ),
                SizedBox(height: 13),
                SimpleImportButton(
                  text: "READ IN DIRECTIONS",
                  onTap: () {
                    Get.toNamed(AppRoutes.importYourPermit);
                  },
                  leftIcon: "assets/icons/Mic-white.svg",
                  rightIcon: 'assets/images/question.png',
                  onTab: () => dialogReadInDirection(context),
                ),
                SizedBox(height: 13),
                SimpleImportButton(
                  text: "PLACE PINS ON MAP",
                  onTap: () {
                    Get.toNamed(AppRoutes.importYourPermit);
                  },
                  leftIcon: "assets/icons/Vector-hand.svg",
                  rightIcon: 'assets/images/question.png',
                  onTab: () => dialogMap(context),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomNavbar() ,
    );
  }
}
