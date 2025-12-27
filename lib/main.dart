import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'core/routes/all_routes.dart';

void main() {
  // 🔥 TRANSPARENT STATUS BAR WITH WHITE ICONS
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,        // Transparent status bar
      statusBarIconBrightness: Brightness.light, // Android white icons
      statusBarBrightness: Brightness.dark,      // iOS white icons
    ),
  );

  runApp(const MyApp());
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
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.dark,
              ),
            ),
          ),
          initialRoute: AppRoutes.splashScreen,
          navigatorKey: Get.key,
          getPages: AppRoutes.routes,
        );
      },
    );
  }
}




// import 'package:device_preview/device_preview.dart';
// import 'package:flutter/foundation.dart'; // For kDebugMode
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'core/routes/all_routes.dart';
//
// void main() {
//   // 🔥 TRANSPARENT STATUS BAR WITH WHITE ICONS
//   SystemChrome.setSystemUIOverlayStyle(
//     const SystemUiOverlayStyle(
//       statusBarColor: Colors.transparent,
//       statusBarIconBrightness: Brightness.light,
//       statusBarBrightness: Brightness.dark,
//     ),
//   );
//
//   runApp(
//     DevicePreview(
//       enabled: kDebugMode, // Only enable in debug mode
//       builder: (context) => const MyApp(),
//     ),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: const Size(440, 956),
//       minTextAdapt: true,
//       splitScreenMode: true,
//       builder: (context, child) {
//         return GetMaterialApp(
//           title: 'Right Routes',
//           debugShowCheckedModeBanner: false,
//
//           // 🔥 Device Preview Configuration
//           locale: DevicePreview.locale(context),
//           builder: DevicePreview.appBuilder,
//
//           theme: ThemeData(
//             useMaterial3: true,
//             colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//             appBarTheme: const AppBarTheme(
//               systemOverlayStyle: SystemUiOverlayStyle(
//                 statusBarColor: Colors.transparent,
//                 statusBarIconBrightness: Brightness.light,
//                 statusBarBrightness: Brightness.dark,
//               ),
//             ),
//           ),
//           initialRoute: AppRoutes.splashScreen,
//           navigatorKey: Get.key,
//           getPages: AppRoutes.routes,
//         );
//       },
//     );
//   }
// }