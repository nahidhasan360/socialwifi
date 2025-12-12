import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:right_routes/core/routes/all_routes.dart';
import 'package:right_routes/global_widgets/custom_navbar.dart';
import 'package:right_routes/utils/colors.dart';
import '../../../utils/assets_manager.dart';
import '../../authentication/login_account/login_account.dart';

// -----------------------------------------------------------------------------
// CONTROLLER (GetX)
// -----------------------------------------------------------------------------
class ManageAccountController extends GetxController {
  RxBool showPassword = false.obs;

  void togglePassword() {
    showPassword.value = !showPassword.value;
  }
}

// -----------------------------------------------------------------------------
// COLOR PALETTE
// -----------------------------------------------------------------------------
class RRColors {
  static const Color bgDarkBlue = Color(0xFF020B2E);
  static const Color accentOrange = Color(0xFFFF7A29);
  static const Color white = Colors.white;
}

// -----------------------------------------------------------------------------
//   // ============= TEXT STYLES
// -----------------------------------------------------------------------------
// class RRText {
//   // New style for the main screen header/title
//   static TextStyle mainScreenHeader = GoogleFonts.lato(
//     color: RRColors.white, // Use the predefined white
//     fontSize: 28.sp,
//     fontWeight: FontWeight.w700,
//     height: 1.14,
//     letterSpacing: 1,
//   );
//
//   // ===============================================================================
//
//   static TextStyle sectionTitle = GoogleFonts.lato(
//     color: RRColors.accentOrange,
//     fontSize: 17.sp,
//     fontWeight: FontWeight.w700,
//   );
//   // ===============================================================================
//
//   static TextStyle label = GoogleFonts.lato(
//     color: Colors.white,
//     fontSize: 18,
//     fontWeight: FontWeight.w500,
//     height: 1.56,
//   );
//   // ===============================================================================
//
//   static TextStyle value = GoogleFonts.lato(
//     color: Colors.white,
//     fontSize: 18,
//     fontWeight: FontWeight.w700,
//     height: 1.56,
//   );
//   // ===============================================================================
//
//   static TextStyle version = GoogleFonts.lato(
//     color: const Color(0xFFF58842),
//     fontSize: 18,
//     fontWeight: FontWeight.w500,
//     height: 1.56,
//   );
// }
// ===============================================================================

// -----------------------------------------------------------------------------
// REUSABLE WIDGETS
// -----------------------------------------------------------------------------
class RRRightArrowTile extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const RRRightArrowTile({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w700,
                height: 1.56,
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: RRColors.white, size: 26.sp),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// MAIN SCREEN
// -----------------------------------------------------------------------------
class AccountScreen extends StatelessWidget {
   AccountScreen({super.key});

  final c = Get.put(ManageAccountController());

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
        child: Column(
      children: [
      SizedBox(height: 50.h),

      // Sticky Logo (Always stays at the top)
      _buildLogo(),

      // Scrollable Body
      Expanded(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              _buildSectionTitle("Manage Account"),
              _buildDivider(),
              _buildEmailSection(),
              SizedBox(height: 1.h),
              _buildPasswordSection(),
              SizedBox(height: 17.h),
              _buildRouteHistory(),
              SizedBox(height: 13.h),
              _buildDivider(),
              _buildCurrentPlan(),
              _buildDivider(),
              _buildCustomerCare(),
              _buildDivider(),
              _buildLegalSection(),
              _buildDivider(),
              SizedBox(height: 12.h),
              _buildVersion(),
              SizedBox(height: 18.h),
              _buildExitButton(),
              SizedBox(height: 60.h),
            ],
          ),
        ),
      ),
      ],
    ),

    ),
      bottomNavigationBar: CustomNavbar(),
    );
  }






  // =====================================   logo ================================
  Widget _buildLogo() {
    return Center(
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
    );
  }

  // ======================= screen header ==============================
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontSize: 28,
        fontFamily: 'Lato',
        fontWeight: FontWeight.w700,
        height: 1.14,
        letterSpacing: 1,
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(color: AppColors.white, thickness: 1);
  }

  Widget _buildEmailSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Email:",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w500,
            height: 1.56,
          ),
        ),
        RRRightArrowTile(
          title: "tanvirhasancr890890@gmail.com",
          onTap: () {
            // Navigate to email management page or show more options
           Get.toNamed(AppRoutes.changeEmail);
          },
        ),
        SizedBox(height: 8.h),
      ],
    );
  }

  Widget _buildPasswordSection() {
    return Row(
      children: [
        SizedBox(height: 15),
        Text(
          "Password",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w500,
            height: 1.56,
          ),
        ),
        SizedBox(width: 6.w),
        Obx(() {
          return GestureDetector(
            onTap: c.togglePassword,
            child: Icon(
              c.showPassword.value ? Icons.visibility_off : Icons.visibility,
              size: 24.sp,
              color: AppColors.white,
            ),
          );
        }),
      ],
    );
  }

  Widget _buildRouteHistory() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          return Text(
            c.showPassword.value ? "mypassword123" : "***************",
            style: TextStyle(
              color: Colors.white,
              fontSize: 31.h,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w700,
              height: 0.88,
            ),
          );
        }),
        RRRightArrowTile(
          title: "My Route History",
          onTap: () {
            // Navigate to route history screen
            Get.to(() => LoginAccount());
          },
        ),
      ],
    );
  }





  Widget _buildCurrentPlan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15),
        Text(
          "MY CURRENT PLAN",
          style: TextStyle(
            color: const Color(0xFFF58842),
            fontSize: 24,
            fontFamily: 'League Gothic',
            fontWeight: FontWeight.w400,
            height: 1.17,
            letterSpacing: 1.50,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          "[ Plan name here ]",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w500,
            height: 1.56,
          ),
        ),
        Text(
          "Users: xxxx",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w500,
            height: 1.56,
          ),
        ),
        Text(
          "Renewal Date: Nov 29, 2025",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w500,
            height: 1.56,
          ),
        ),
        SizedBox(height: 10.h),
        _buildPlanActions(),
      ],
    );
  }

  Widget _buildPlanActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text.rich(
              TextSpan(
                text: "Team Plans: ",
                style: TextStyle(
                  color: const Color(0xFFF58842),
                  fontSize: 18,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w500,
                  height: 1.56,
                ),
                children: [
                  TextSpan(
                    text: "Upgrade or Downgrade",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w500,
                      height: 1.56,
                    ),
                  ),
                ],
              ),
            ),
            RRRightArrowTile(
              onTap: () {
                // Navigate to help center
                Get.to(() => LoginAccount());
              },
              title: '',
            ),
          ],
        ),
        RRRightArrowTile(
          title: "Manage Team",
          onTap: () {
            // Navigate to manage team page
            Get.to(() => LoginAccount());
          },
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text.rich(
              TextSpan(
                text: "Single User Plan: ",
                style: TextStyle(
                  color: const Color(0xFFF58842),
                  fontSize: 18,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w500,
                  height: 1.56,
                ),
                children: [
                  TextSpan(
                    text: "Upgrade to Yearly Plan",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w500,
                      height: 1.56,
                    ),
                  ),
                ],
              ),
            ),

            RRRightArrowTile(
              onTap: () {
                // Navigate to help center
                Get.to(() => LoginAccount());
              },
              title: '',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCustomerCare() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.h),
        Text(
          "CUSTOMER CARE",
          style: TextStyle(
            color: const Color(0xFFF58842),
            fontSize: 24,
            fontFamily: 'League Gothic',
            fontWeight: FontWeight.w400,
            height: 1.17,
            letterSpacing: 1.50,
          ),
        ),
        SizedBox(height: 10.h),
        RRRightArrowTile(
          title: "Contact Support",
          onTap: () {
            // Navigate to support page
           Get.toNamed(AppRoutes.contactSupport);
          },
        ),
        RRRightArrowTile(
          title: "Help Center",
          onTap: () {
            // Navigate to help center
            Get.to(() => LoginAccount());
          },
        ),
      ],
    );
  }

  Widget _buildLegalSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 17.h),
        Text(
          "LEGAL",
          style: TextStyle(
            color: const Color(0xFFF58842),
            fontSize: 24,
            fontFamily: 'League Gothic',
            fontWeight: FontWeight.w400,
            height: 1.17,
            letterSpacing: 1.50,
          ),
        ),
        SizedBox(height: 10.h),
        RRRightArrowTile(
          title: "Privacy Policy",
          onTap: () {
            // Navigate to privacy policy page
            Get.to(() => ());
          },
        ),
        RRRightArrowTile(
          title: "Terms of Use",
          onTap: () {
            // Navigate to terms of use page
            Get.to(() => LoginAccount());
          },
        ),
        RRRightArrowTile(
          title: "Right Route Subscriber Agreement",
          onTap: () {
            // Navigate to subscriber agreement page
            Get.to(() => LoginAccount());
          },
        ),
        RRRightArrowTile(
          title: "Log out",
          onTap: () {
            // Perform log out action
            Get.to(() => LoginAccount());
          },
        ),
        RRRightArrowTile(
          title: "Delete Account",
          onTap: () {
            // Navigate to delete account screen
            Get.to(() => LoginAccount());
          },
        ),
      ],
    );
  }

  Widget _buildVersion() {
    return Text(
      "Version 0.0.0",
      style: TextStyle(
        color: const Color(0xFFF58842),
        fontSize: 18,
        fontFamily: 'Lato',
        fontWeight: FontWeight.w500,
        height: 1.56,
      ),
    );
  }

  Widget _buildExitButton() {
    return Center(
      child: Container(
        width: double.infinity,
        height: 50.h,
        decoration: BoxDecoration(
          color: RRColors.accentOrange,
          borderRadius: BorderRadius.circular(12.r),
        ),
        alignment: Alignment.center,
        child: Text(
          "EXIT",
          style: GoogleFonts.montserrat(
            fontSize: 17.sp,
            color: RRColors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
