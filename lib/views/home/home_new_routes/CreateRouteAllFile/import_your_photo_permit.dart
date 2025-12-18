import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:right_routes/core/routes/all_routes.dart';
import 'package:right_routes/global_widgets/custom_navbar.dart';
import 'package:right_routes/utils/assets_manager.dart';
import 'package:right_routes/utils/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class ImportYourPhotoPermit extends StatefulWidget {
  const ImportYourPhotoPermit({super.key});

  @override
  State<ImportYourPhotoPermit> createState() => _ImportYourPhotoPermitState();
}

class _ImportYourPhotoPermitState extends State<ImportYourPhotoPermit> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  // Show bottom sheet with camera and gallery options
  void _showImageSourceOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.darkGray,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SafeArea(
            child: Wrap(
              children: [
                // Header
                Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Center(
                    child: Text(
                      'Select Image Source',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),

                Divider(color: Colors.white24, height: 1),

                // Camera Option
                ListTile(
                  leading: Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: AppColors.orange,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/Camera-white.svg",
                      height: 23,
                      width: 23,
                    ),
                  ),
                  title: Text(
                    'Take Photo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    'Open camera to take a photo',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontFamily: 'Lato',
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImageFromCamera();
                  },
                ),

                Divider(
                  color: Colors.white24,
                  height: 1,
                  indent: 16,
                  endIndent: 16,
                ),

                // Gallery Option
                ListTile(
                  leading: Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: AppColors.orange,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      Icons.photo_library_outlined,
                      color: AppColors.white,
                      size: 23,
                    ),
                  ),
                  title: Text(
                    'Choose from Gallery',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    'Select from your photo library',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontFamily: 'Lato',
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImageFromGallery();
                  },
                ),

                SizedBox(height: 10.h),
              ],
            ),
          ),
        );
      },
    );
  }

  // Pick image from camera
  Future<void> _pickImageFromCamera() async {
    try {
      // Request camera permission
      PermissionStatus status = await Permission.camera.request();

      if (status.isGranted) {
        final XFile? photo = await _picker.pickImage(
          source: ImageSource.camera,
          imageQuality: 85,
          preferredCameraDevice: CameraDevice.rear,
        );

        if (photo != null) {
          setState(() {
            _selectedImage = File(photo.path);
          });

          print('Photo captured: ${photo.path}');

          // Show snackbar at top
          Get.snackbar(
            'Success',
            'Photo captured successfully',
            backgroundColor: Colors.green.withValues(alpha: 0.8),
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            margin: EdgeInsets.all(16),
            duration: Duration(seconds: 2),
          );

          // TODO: Process image with OCR to extract directions
        }
      } else if (status.isPermanentlyDenied) {
        _showPermissionDialog('Camera');
      } else {
        Get.snackbar(
          'Permission Denied',
          'Camera access is required to take photos',
          backgroundColor: Colors.orange.withValues(alpha: 0.8),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          margin: EdgeInsets.all(16),
        );
      }
    } catch (e) {
      print('Error capturing photo: $e');
      Get.snackbar(
        'Error',
        'Failed to capture photo',
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(16),
      );
    }
  }

  // Pick image from gallery
  Future<void> _pickImageFromGallery() async {
    try {
      // Request photo library permission
      PermissionStatus status = await Permission.photos.request();

      if (status.isDenied) {
        // Try storage permission for older Android versions
        status = await Permission.storage.request();
      }

      if (status.isGranted || status.isLimited) {
        final XFile? image = await _picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 85,
        );

        if (image != null) {
          setState(() {
            _selectedImage = File(image.path);
          });

          print('Image selected: ${image.path}');

          // Show snackbar at top
          Get.snackbar(
            'Success',
            'Image imported successfully',
            backgroundColor: Colors.green.withValues(alpha: 0.8),
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            margin: EdgeInsets.all(16),
            duration: Duration(seconds: 2),
          );

          // TODO: Process image with OCR to extract directions
        }
      } else if (status.isPermanentlyDenied) {
        _showPermissionDialog('Photos');
      } else {
        Get.snackbar(
          'Permission Denied',
          'Photo library access is required to import images',
          backgroundColor: Colors.orange.withValues(alpha: 0.8),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          margin: EdgeInsets.all(16),
        );
      }
    } catch (e) {
      print('Error picking image: $e');
      Get.snackbar(
        'Error',
        'Failed to import image',
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(16),
      );
    }
  }

  // Show permission dialog to open settings
  void _showPermissionDialog(String permissionType) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xFF2C3E50),
        title: Text(
          'Permission Required',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          '$permissionType access is permanently denied. Please enable it in app settings to continue.',
          style: TextStyle(color: Colors.white70, fontFamily: 'Lato'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: Colors.white70)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              openAppSettings();
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.orange),
            child: Text('Open Settings', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

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
              SizedBox(height:29),

              // ========== Scrollable Content Section ==========
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ========== Title with Info Icon ==========
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'IMPORT A PHOTO OF YOUR PERMIT',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontFamily: 'League Gothic',
                              fontWeight: FontWeight.w400,
                              height: 0.88,
                               letterSpacing: 1,
                            ),
                          ),
                          SizedBox(width: 4),
                          GestureDetector(
                            onTap: () {
                              showImportPermitInfoDialog(context);
                            },
                            child: SvgPicture.asset(
                              "assets/icons/Question-Box-gray.svg",
                              width: 20,
                              height: 20,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),

                      // ========== First Instruction Paragraph ==========
                      Text(
                        "Place your permit on a flat surface and use this device's camera to take a photo in vertical format. Take a photo of only one permit at a time. Be sure the permit fills the entire screen and is in focus.\nSave it then return here to Import.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 5),
                      // ========== Second Instruction Paragraph ==========
                      Text(
                        'After importing, edit as needed or import your next permit image before tapping Continue.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w500,
                          height: 1.44,
                        ),
                      ),
                      SizedBox(height: 24),

                      // ========== Import Button - Opens Bottom Sheet ==========
                     Row(
                       children: [
                         GestureDetector(
                           onTap: _showImageSourceOptions,
                           child: Container(
                             width: 64,
                             height: 24,
                             decoration: BoxDecoration(
                               color: AppColors.orange,
                               borderRadius: BorderRadius.circular(5.r),
                             ),
                             child: Center(
                               child: Text(
                                 'Import',
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
                         SizedBox(width: 5,),
                         GestureDetector(
                           onTap: () {
                             showImportPermitInfoDialog(context);
                           },
                           child: SvgPicture.asset(
                             "assets/icons/Question-Box-gray.svg",
                             width: 20,
                             height: 20,
                           ),
                         ),
                       ],
                     ),
                      SizedBox(height: 15.h),

                      // ========== NO IMAGE PREVIEW - Removed ==========
                      // Image is stored in _selectedImage but not displayed

                      // ========== Extracted Directions Card ==========
                      Container(
                        width: double.infinity,
                        height: 246,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            left: BorderSide(
                              color: Color(0xFF1A2332),
                              width: 3,
                            ),
                          ),
                        ),
                        padding: EdgeInsets.only(
                          left: 15.w,
                          top: 17.h,
                          bottom: 12.h,
                          right: 16.w,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'I-29 S',
                              style: TextStyle(
                                color: const Color(0xFF141414),
                                fontSize: 20,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w500,
                                height: 1.40,
                              ),
                            ),
                            Text(
                              'Exit 63A-B',
                              style: TextStyle(
                                color: const Color(0xFF141414),
                                fontSize: 20,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w500,
                                height: 1.40,
                              ),
                            ),
                            Text(
                              'Exit 63B',
                              style: TextStyle(
                                color: const Color(0xFF141414),
                                fontSize: 20,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w500,
                                height: 1.40,
                              ),
                            ),
                            Text(
                              'I-94 W',
                              style: TextStyle(
                                color: const Color(0xFF141414),
                                fontSize: 20,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w500,
                                height: 1.40,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.h),

                      // ========== Bottom Action Buttons Row ==========
                      Row(
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

                          Spacer(),

                          // Continue Button
                          GestureDetector(
                            onTap: () {
                              if (_selectedImage != null) {
                                print(
                                  'Continue with image: ${_selectedImage!.path}',
                                );
                               Get.toNamed(AppRoutes.editConfirmStartYourRoute);
                              } else {
                                Get.snackbar(
                                  'No Image',
                                  'Please import a permit image first',
                                  backgroundColor: Colors.orange.withValues(alpha:
                                    0.8,
                                  ),
                                  colorText: Colors.white,
                                  snackPosition: SnackPosition.TOP,
                                  margin: EdgeInsets.all(16),
                                );
                              }
                            },
                            child: Container(
                              width: 76,
                              height: 24,
                              decoration: BoxDecoration(
                                color: AppColors.orange,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Center(
                                child: Text(
                                  'Continue',
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
                        ],
                      ),

                      SizedBox(height: 40.h),
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

// ========== DIALOG FUNCTION ==========
void showImportPermitInfoDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.only(bottom: 305.h, left: 20.w, right: 20.w),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Color(0xFF4A4A4A),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    "assets/icons/Import_white.svg",
                    width: 29,
                    height: 29,
                    color: Colors.white,
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
                "To import the image of your permit, tap Import then choose to take a photo with your camera or select from your photo library.\nThis app will automatically extract the directions from the image which will appear in the field below.",
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
      );
    },
  );
}
