import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:right_routes/global_widgets/custom_navbar.dart';
import 'package:right_routes/utils/assets_manager.dart';
import 'package:right_routes/utils/colors.dart';
import 'package:right_routes/views/home/account_screen/account_screen.dart';

// ============================================================
// COLOR CONSTANTS
// ============================================================
class TeamManagerColors {
  static const Color primaryOrange = Color(0xFFFF8742);
  static const Color primaryWhite = Color(0xFFFFFFFF);
  static const Color darkBackground = Color(0xFF1E1E1E);
  static const Color darkerBackground = Color(0xFF0F0F0F);
  static const Color borderColor = Color(0xFF3A3A3A);
}

// ============================================================
// CONTROLLER - GetX State Management
// ============================================================
class TeamManagerController extends GetxController {
  final searchController = TextEditingController();
  final emailInputController = TextEditingController();
  final emailInputFocusNode = FocusNode(); // For keyboard control

  var userList = <UserModel>[].obs;
  var filteredUserList = <UserModel>[].obs;
  var isAllSelected = false.obs;

  final userListScrollController = ScrollController();
  final emailInputScrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    loadSampleUsers();

    searchController.addListener(() {
      filterUsers(searchController.text);
    });

    // Initialize email input scroll to 20% position
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (emailInputScrollController.hasClients) {
        final maxScroll = emailInputScrollController.position.maxScrollExtent;
        if (maxScroll > 0) {
          emailInputScrollController.jumpTo(maxScroll * 0.2);
        }
      }
    });
  }

  void loadSampleUsers() {
    userList.value = [
      UserModel(
        name: 'John Doe',
        email: 'john@truck.com...',
        status: UserStatus.active,
        isSelected: false,
      ),
      UserModel(
        name: 'Mark Smith',
        email: 'marksmith@truc...',
        status: UserStatus.pending,
        isSelected: false,
      ),
      UserModel(
        name: 'Sarah Johnson',
        email: 'sarah@truc...',
        status: UserStatus.resend,
        isSelected: false,
      ),
      UserModel(
        name: 'Sam Cline',
        email: 'samcline@truc...',
        status: UserStatus.active,
        isSelected: false,
      ),
      UserModel(
        name: 'Emily Davis',
        email: 'emily@truck.com...',
        status: UserStatus.pending,
        isSelected: false,
      ),
      UserModel(
        name: 'Michael Brown',
        email: 'michael@truc...',
        status: UserStatus.active,
        isSelected: false,
      ),
      UserModel(
        name: 'Jessica Wilson',
        email: 'jessica@truc...',
        status: UserStatus.resend,
        isSelected: false,
      ),
      UserModel(
        name: 'David Lee',
        email: 'david@truck.com...',
        status: UserStatus.active,
        isSelected: false,
      ),
    ];
    filteredUserList.value = userList;
  }

  void filterUsers(String query) {
    if (query.isEmpty) {
      filteredUserList.value = userList;
    } else {
      filteredUserList.value = userList
          .where(
            (user) =>
                user.name.toLowerCase().contains(query.toLowerCase()) ||
                user.email.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }
  }

  void toggleUserSelection(int index) {
    filteredUserList[index].isSelected = !filteredUserList[index].isSelected;
    filteredUserList.refresh();
    _updateSelectAllState();
  }

  void toggleAllSelection() {
    isAllSelected.value = !isAllSelected.value;
    for (var user in filteredUserList) {
      user.isSelected = isAllSelected.value;
    }
    filteredUserList.refresh();
  }

  void _updateSelectAllState() {
    if (filteredUserList.isEmpty) {
      isAllSelected.value = false;
      return;
    }
    isAllSelected.value = filteredUserList.every((user) => user.isSelected);
  }

  void editUser(UserModel user) {
    emailInputController.text = '${user.name}, ${user.email}';
    Get.snackbar(
      'Edit Mode',
      'User loaded in ADD/EDIT USERS box. Modify and click Add to update.',
      backgroundColor: TeamManagerColors.primaryOrange,
      colorText: Colors.white,
    );
  }

  UserModel? parseSingleEntry(String entry) {
    try {
      final parts = entry.split(',').map((e) => e.trim()).toList();
      if (parts.length != 2) return null;

      final name = parts[0];
      final email = parts[1];

      if (name.isEmpty || email.isEmpty || !email.contains('@')) {
        return null;
      }

      return UserModel(
        name: name,
        email: email,
        status: UserStatus.pending,
        isSelected: false,
      );
    } catch (e) {
      return null;
    }
  }

  List<UserModel> parseMultipleEntries(String csvData) {
    final lines = csvData
        .split('\n')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
    final users = <UserModel>[];

    for (final line in lines) {
      final user = parseSingleEntry(line);
      if (user != null) {
        users.add(user);
      }
    }

    return users;
  }

  void addUserEmail() {
    final input = emailInputController.text.trim();

    if (input.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter user information',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    final singleUser = parseSingleEntry(input);
    if (singleUser != null) {
      userList.add(singleUser);
      filteredUserList.value = userList;
      emailInputController.clear();

      Get.snackbar(
        'Success',
        'User invitation sent to ${singleUser.email}',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      return;
    }

    final multipleUsers = parseMultipleEntries(input);
    if (multipleUsers.isNotEmpty) {
      userList.addAll(multipleUsers);
      filteredUserList.value = userList;
      emailInputController.clear();

      Get.snackbar(
        'Success',
        '${multipleUsers.length} user(s) added successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      return;
    }

    Get.snackbar(
      'Invalid Format',
      'Please use format: "Firstname Lastname, email@email.com"',
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  void importUsers() {
    CustomDialogs.showHelpDialog();
  }

  void downloadSelected() {
    final selected = filteredUserList.where((user) => user.isSelected).toList();
    if (selected.isEmpty) {
      Get.snackbar(
        'Warning',
        'Please select at least one user',
        backgroundColor: TeamManagerColors.primaryOrange,
        colorText: Colors.white,
      );
      return;
    }
    Get.snackbar('Info', '${selected.length} users selected for download');
  }

  void cancelSelected() {
    final selected = filteredUserList.where((user) => user.isSelected).toList();
    if (selected.isEmpty) {
      Get.snackbar(
        'Warning',
        'Please select at least one user',
        backgroundColor: TeamManagerColors.primaryOrange,
        colorText: Colors.white,
      );
      return;
    }
    Get.snackbar('Info', '${selected.length} users selected for cancel');
  }

  void resendSelected() {
    final selected = filteredUserList.where((user) => user.isSelected).toList();
    if (selected.isEmpty) {
      Get.snackbar(
        'Warning',
        'Please select at least one user',
        backgroundColor: TeamManagerColors.primaryOrange,
        colorText: Colors.white,
      );
      return;
    }
    Get.snackbar('Info', '${selected.length} users selected for resend');
  }

  void removeSelected() {
    final selected = filteredUserList.where((user) => user.isSelected).toList();

    if (selected.isEmpty) {
      Get.snackbar(
        'Warning',
        'Please select at least one user to remove',
        backgroundColor: TeamManagerColors.primaryOrange,
        colorText: Colors.white,
      );
      return;
    }

    CustomDialogs.showRemoveConfirmation(
      onConfirm: () {
        filteredUserList.removeWhere((user) => user.isSelected);
        userList.removeWhere((user) => user.isSelected);

        Get.back();
        Get.snackbar(
          'Success',
          '${selected.length} user(s) removed successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      },
    );
  }

  @override
  void onClose() {
    searchController.dispose();
    emailInputController.dispose();
    emailInputFocusNode.dispose();
    userListScrollController.dispose();
    emailInputScrollController.dispose();
    super.onClose();
  }
}

// ============================================================
// USER MODEL
// ============================================================
class UserModel {
  String name;
  String email;
  UserStatus status;
  bool isSelected;

  UserModel({
    required this.name,
    required this.email,
    required this.status,
    this.isSelected = false,
  });
}

enum UserStatus { active, pending, resend, remove }

// ============================================================
// CUSTOM SCROLL INDICATOR - 50h x 8w
// ============================================================
class CustomScrollIndicator extends StatefulWidget {
  final ScrollController scrollController;
  final double containerHeight;

  const CustomScrollIndicator({
    Key? key,
    required this.scrollController,
    required this.containerHeight,
  }) : super(key: key);

  @override
  State<CustomScrollIndicator> createState() => _CustomScrollIndicatorState();
}

class _CustomScrollIndicatorState extends State<CustomScrollIndicator> {
  double _scrollPosition = 0.0;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    if (widget.scrollController.hasClients && mounted) {
      setState(() {
        _scrollPosition = widget.scrollController.offset;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.scrollController.hasClients) {
      return SizedBox.shrink();
    }

    try {
      final position = widget.scrollController.position;
      final maxScroll = position.maxScrollExtent;

      if (maxScroll <= 0) {
        return SizedBox.shrink();
      }

      final viewportHeight = position.viewportDimension;
      final contentHeight = maxScroll + viewportHeight;

      if (contentHeight <= 0 || widget.containerHeight <= 0) {
        return SizedBox.shrink();
      }

      final indicatorHeight =
          (viewportHeight / contentHeight) * widget.containerHeight;
      final maxIndicatorTravel = widget.containerHeight - indicatorHeight;

      if (maxScroll <= 0) {
        return SizedBox.shrink();
      }

      final indicatorTop = (_scrollPosition / maxScroll) * maxIndicatorTravel;

      return Positioned(
        right: 5.w,
        top: indicatorTop.clamp(5, maxIndicatorTravel),
        child: GestureDetector(
          onVerticalDragUpdate: (details) {
            try {
              final dragRatio = details.delta.dy / widget.containerHeight;
              final scrollDelta = dragRatio * maxScroll;
              final newScroll = (_scrollPosition + scrollDelta).clamp(
                0.0,
                maxScroll,
              );
              widget.scrollController.jumpTo(newScroll);
            } catch (e) {}
          },
          onTapDown: (details) {
            try {
              final tapPosition = details.localPosition.dy;
              final scrollRatio = tapPosition / widget.containerHeight;
              final newScroll = (scrollRatio * maxScroll).clamp(0.0, maxScroll);
              widget.scrollController.animateTo(
                newScroll,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            } catch (e) {}
          },
          child: Container(
            width: 5.w,
            height: indicatorHeight.clamp(5.h, widget.containerHeight),
            decoration: BoxDecoration(
              color: TeamManagerColors.primaryOrange,
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
        ),
      );
    } catch (e) {
      return SizedBox.shrink();
    }
  }
}

// ============================================================
// CUSTOM DIALOGS
// ============================================================
class CustomDialogs {
  static void showRemoveConfirmation({required VoidCallback onConfirm}) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFB71C1C),
            borderRadius: BorderRadius.circular(8.r),
          ),
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.notifications_outlined,
                color: Colors.white,
                size: 32.sp,
              ),
              SizedBox(height: 16.h),
              Text(
                'You are about to remove the selected User(s). Tap confirm to continue.',
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(6.r),
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                        child: Center(
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: GestureDetector(
                      onTap: onConfirm,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Center(
                          child: Text(
                            'Confirm',
                            style: GoogleFonts.lato(
                              color: const Color(0xFFB71C1C),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }

  static void showHelpDialog() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF5A5A5A),
            borderRadius: BorderRadius.circular(8.r),
          ),
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.person_add_outlined,
                    color: Colors.white,
                    size: 28.sp,
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
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
              SizedBox(height: 16.h),
              _buildInstructionText(
                title: 'Single entry:',
                content:
                    'Tap inside field below, type first/last name and email separated by a comma. ',
              ),
              _buildInstructionText(
                title: 'Example:',
                content: '[sample format: Firstname Lastname, email@email.com]',
                isExample: true,
              ),
              SizedBox(height: 12.h),
              _buildInstructionText(
                title: 'Multiple entries:',
                content:
                    'Tap Import. List must be comma delineated in .CSV format, one user per line.',
              ),
              SizedBox(height: 12.h),
              Text(
                'After import, tap on name or email to edit. Clicking on Add moves the list to the Users list and automatically sends invite emails.',
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }

  static Widget _buildInstructionText({
    required String title,
    required String content,
    bool isExample = false,
  }) {
    return RichText(
      text: TextSpan(
        style: GoogleFonts.lato(
          color: Colors.white,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          height: 1.5,
        ),
        children: [
          TextSpan(
            text: title,
            style: GoogleFonts.lato(fontWeight: FontWeight.w700),
          ),
          TextSpan(text: ' '),
          TextSpan(
            text: content,
            style: GoogleFonts.lato(
              fontStyle: isExample ? FontStyle.italic : FontStyle.normal,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// MAIN SCREEN
// ============================================================
class TeamManager extends StatelessWidget {
  TeamManager({super.key});

  final controller = Get.put(TeamManagerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // ✅ Keyboard shows above input
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 20.h),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Container(
                      width: 225.w,
                      height: 112.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(ImageManager.splashScreenLogo),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 32.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Team Manager',
                        style: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                          height: 0.88,
                        ),
                      ),
                      SizedBox(height: 13.h),
                      Divider(color: AppColors.dividerColor, thickness: 1.h),
                      SizedBox(height: 17.h),
                      _buildSubscriptionInfo(),
                      SizedBox(height: 20.h),
                      Divider(color: AppColors.dividerColor, thickness: 1.h),
                      SizedBox(height: 20.h),
                      _buildUsersSection(),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Manage Account',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: const Color(0xFF9DACF5),
                            fontSize: 18,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w500,
                            height: 1.78,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomNavbar(),
    );
  }

  Widget _buildSubscriptionInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoText('Team [sample data: 1,000 (up to 1,000 users)]'),
        _buildInfoText('Seats used: [sample data: 785 of 1,000]'),
        _buildInfoText('Renewal Date: [sample data: Nov 29, 2025]'),
        _buildInfoText('Subscription ID: [subscription ID here]'),
        Text(
          'Upgrade / Downgrade',
          style: GoogleFonts.lato(
            color: const Color(0xFF9DACF5),
            fontSize: 18.sp,
            fontWeight: FontWeight.w400,
            height: 1.56,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoText(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Text(
        text,
        style: GoogleFonts.lato(
          color: Colors.white,
          fontSize: 18.sp,
          fontWeight: FontWeight.w400,
          height: 1.56,
        ),
      ),
    );
  }

  Widget _buildUsersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSearchHeader(),
        SizedBox(height: 16.h),
        _buildUserListTable(),
        SizedBox(height: 16.h),
        _buildActionButtons(),
        SizedBox(height: 24.h),
        _buildAddEditUsersSection(),
        SizedBox(height: 25.h),
        Divider(color: AppColors.dividerColor, thickness: 1.h),
        SizedBox(height: 10.h),
      ],
    );
  }

  Widget _buildSearchHeader() {
    return Row(
      children: [
        Text(
          'USERS',
          style: GoogleFonts.leagueGothic(
            color: const Color(0xFFF58842),
            fontSize: 24,
            fontWeight: FontWeight.w400,
            height: 1.17,
            letterSpacing: 1.50,
          ),
        ),
        Spacer(),
        Row(
          children: [
            Icon(Icons.search, color: TeamManagerColors.primaryWhite, size: 24),
            SizedBox(width: 2.w),
            Container(
              width: 195,
              height: 32,
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              decoration: BoxDecoration(
                color: AppColors.medGray,
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Material(
                color: Colors.transparent,
                child: TextField(
                  controller: controller.searchController,
                  cursorColor: AppColors.white,
                  cursorHeight: 18,
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 2.29,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Doe',
                    hintStyle: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.29,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: () {
                controller.filterUsers(controller.searchController.text);
              },
              child: Container(
                width: 33,
                height: 32,
                decoration: BoxDecoration(
                  color: TeamManagerColors.borderColor,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Center(
                  child: Text(
                    'GO',
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      height: 2,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUserListTable() {
    return Obx(() {
      if (controller.filteredUserList.isEmpty) {
        return _buildEmptyState();
      }

      final containerHeight = (56.h * 4);

      return Container(
        decoration: BoxDecoration(
          color: AppColors.darkGray,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: TeamManagerColors.borderColor, width: 1),
        ),
        child: Column(
          children: [
            _buildTableHeader(),
            Stack(
              children: [
                Container(
                  constraints: BoxConstraints(maxHeight: containerHeight),
                  child: SingleChildScrollView(
                    controller: controller.userListScrollController,
                    child: Column(
                      children: List.generate(
                        controller.filteredUserList.length,
                        (index) => _buildTableRow(index),
                      ),
                    ),
                  ),
                ),
                CustomScrollIndicator(
                  scrollController: controller.userListScrollController,
                  containerHeight: containerHeight,
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  // ✅ UPDATED HEADER: medGray background, checkbox moved right beside Status
  Widget _buildTableHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.darkGray, // ✅ medGray background
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.r),
          topRight: Radius.circular(8.r),
        ),
      ),
      child: Row(
        children: [
          // Name
          Expanded(
            flex: 2,
            child: Text(
              'Name',
              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                height: 1.75,
              ),
            ),
          ),
          // Email
          Expanded(
            flex: 3,
            child: Text(
              'Email',
              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                height: 1.75,
              ),
            ),
          ),
          // Status column (checkbox removed from here)
          Expanded(
            flex: 2,
            child: Text(
              'Status',
              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                height: 1.75,
              ),
            ),
          ),
          // Actions column with Checkbox + Help Icon
          SizedBox(
            width: 100.w, //  Increased width for checkbox + icon
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //  Select All Checkbox moved here (left of question icon)
                Obx(
                  () => GestureDetector(
                    onTap: () {
                      controller.toggleAllSelection();
                    },
                    child: Container(
                      width: 24.w,
                      height: 24.h,
                      decoration: BoxDecoration(
                        color: controller.isAllSelected.value
                            ? TeamManagerColors.primaryOrange
                            : Colors.transparent,
                        border: Border.all(
                          color: TeamManagerColors.primaryWhite,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: controller.isAllSelected.value
                          ? Icon(
                              Icons.check,
                              color: TeamManagerColors.primaryWhite,
                              size: 14.sp,
                            )
                          : null,
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                // Question icon
                GestureDetector(
                  onTap: () {
                    _showUserManagementHelp();
                  },
                  child: Center(
                    child: SvgPicture.asset(
                      "assets/icons/Question-Box-gray.svg",
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showUserManagementHelp() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF5A5A5A),
            borderRadius: BorderRadius.circular(8.r),
          ),
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.white, size: 28.sp),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      'User Management',
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: EdgeInsets.all(4.w),
                      child: SvgPicture.asset(
                        "assets/icons/Close-X-Circle.svg",
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Text(
                '• Click the checkbox to select individual users\n'
                '• Click the checkbox in the header to select/deselect all users\n'
                '• Click the pencil icon to edit a user\'s information\n'
                '• Select users and click action buttons to perform bulk operations',
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }

  Widget _buildTableRow(int index) {
    return Obx(() {
      final user = controller.filteredUserList[index];

      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                user.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.lato(
                  color: _getTextColor(user.status),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              flex: 3,
              child: Text(
                user.email,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.lato(
                  color: _getTextColor(user.status),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              flex: 2,
              child: Text(
                _getStatusText(user.status),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.lato(
                  color: _getTextColor(user.status),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(width: 8.w),
            SizedBox(
              width: 100.w, // ✅ Match header width
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.toggleUserSelection(index);
                    },
                    child: Container(
                      width: 24.w,
                      height: 24.h,
                      decoration: BoxDecoration(
                        color: user.isSelected
                            ? TeamManagerColors.primaryOrange
                            : Colors.transparent,
                        border: Border.all(
                          color: TeamManagerColors.primaryWhite,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: user.isSelected
                          ? Icon(
                              Icons.close,
                              color: TeamManagerColors.primaryWhite,
                              size: 16.sp,
                            )
                          : null,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  GestureDetector(
                    onTap: () {
                      controller.editUser(user);
                    },
                    child: Center(
                      child: SvgPicture.asset(
                        "assets/icons/Edit-Pencil-white.svg",
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildEmptyState() {
    return Container(
      padding: EdgeInsets.all(32.w),
      decoration: BoxDecoration(
        color: AppColors.darkGray,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Center(
        child: Text(
          'No users found',
          style: GoogleFonts.lato(
            color: TeamManagerColors.primaryWhite.withOpacity(0.6),
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }

  // ✅ UPDATED BUTTONS: Content-based width with padding + new style
  // ============================================================
  // ACTION BUTTONS ROW - FULL WIDTH WITH EQUAL SPACING
  // ============================================================
  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: _buildActionButton('Download', controller.downloadSelected),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildActionButton('Cancel', controller.cancelSelected),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildActionButton('Resend', controller.resendSelected),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildActionButton('Remove', controller.removeSelected),
        ),
      ],
    );
  }

  Widget _buildActionButton(String label, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 1), // ✅ Reduced padding
        decoration: BoxDecoration(
          color: TeamManagerColors.primaryOrange,
          borderRadius: BorderRadius.circular(5), // ✅ Border radius 5
        ),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              // ✅ Exact text style
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w800,
              height: 2,
            ),
          ),
        ),
      ),
    );
  }

  //   indicator ar height
  // UPDATED: Question icon 73 left from ADD/EDIT USERS
  Widget _buildAddEditUsersSection() {
    final containerHeight = 265.h;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Row(
            children: [
              Text(
                'ADD / EDIT USERS',
                style: GoogleFonts.leagueGothic(
                  color: AppColors.orange,
                  fontSize: 24,

                  fontWeight: FontWeight.w400,
                  height: 1.17,
                  letterSpacing: 1.50,
                ),
              ),
              SizedBox(width: 73.w),

              // ========================  ADD / USERS AR SECTION =========================
              GestureDetector(
                onTap: () {
                  CustomDialogs.showHelpDialog();
                },
                // child: Container(
                //   width: 24.w,
                //   height: 24.h,
                //   decoration: BoxDecoration(
                //     color: TeamManagerColors.primaryOrange,
                //     shape: BoxShape.circle,
                //     border: Border.all(
                //       color: TeamManagerColors.primaryWhite, // White border
                //       width: 1.5,
                //     ),
                //   ),
                child: Center(
                  child: SvgPicture.asset("assets/icons/Question-Box-gray.svg"),
                ),
              ),
            ],
          ),
        ),
        Stack(
          children: [
            Container(
              height: containerHeight,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8.r),
                  bottomRight: Radius.circular(8.r),
                ),
                border: Border.all(
                  color: TeamManagerColors.borderColor,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      controller: controller.emailInputScrollController,
                      child: TextField(
                        controller: controller.emailInputController,
                        focusNode:
                            controller.emailInputFocusNode, // ✅ Focus node
                        maxLines: null,
                        minLines: 10,
                        style: GoogleFonts.lato(
                          color: Colors.black,
                          fontSize: 14.sp,
                        ),
                        decoration: InputDecoration(
                          hintText: 'john@truckcompany.com',
                          hintStyle: GoogleFonts.lato(
                            color: Colors.black.withOpacity(0.4),
                            fontSize: 14.sp,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ),
                  // ✅ Divider above +215
                  Divider(color: AppColors.darkGray, thickness: 1),
                  Text(
                    '+ 215',
                    style: GoogleFonts.lato(
                      color: Colors.green,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            CustomScrollIndicator(
              scrollController: controller.emailInputScrollController,
              containerHeight: containerHeight,
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              child: _buildActionButton('Import', controller.importUsers),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildActionButton('Cancel', () {
                controller.emailInputController.clear();
              }),
            ),
            SizedBox(width: 12.w),
            Expanded(child: _buildActionButton('Add', controller.addUserEmail)),
          ],
        ),
      ],
    );
  }

  Color _getTextColor(UserStatus status) {
    switch (status) {
      case UserStatus.active:
        return TeamManagerColors.primaryOrange;
      case UserStatus.pending:
        return TeamManagerColors.primaryWhite;
      case UserStatus.resend:
        return TeamManagerColors.primaryOrange;
      case UserStatus.remove:
        return TeamManagerColors.primaryWhite;
    }
  }

  String _getStatusText(UserStatus status) {
    switch (status) {
      case UserStatus.active:
        return 'Active';
      case UserStatus.pending:
        return 'Pending';
      case UserStatus.resend:
        return 'Resend';
      case UserStatus.remove:
        return 'Remove';
    }
  }
}
