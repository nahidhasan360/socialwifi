import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'core/routes/all_routes.dart';

void main() {
  // 🔥 TRANSPARENT STATUS BAR WITH WHITE ICONS
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,            // ✅ Transparent background (body will be visible)
      statusBarIconBrightness: Brightness.light,     // ✅ Android white icons
      statusBarBrightness: Brightness.dark,          // ✅ iOS white icons
    ),
  );

  // Run the app with DevicePreview enabled only in debug mode
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) =>  MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(440, 956),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Right Routes',
          locale: DevicePreview.locale(context), // For device preview locale handling
          builder: DevicePreview.appBuilder, // DevicePreview builder to adjust screen sizes
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.dark,
              ),
            ),
          ),
          initialRoute: AppRoutes.help, // Ensure this route is defined in your AppRoutes
          navigatorKey: Get.key, // Global navigator key for GetX
          getPages: AppRoutes.routes, // Define your pages here
        );
      },
    );
  }
}
