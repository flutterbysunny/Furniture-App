import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:sizer/sizer.dart';

import 'app/routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Ev Charging",

          builder: (context, child) => ResponsiveBreakpoints.builder(
            child: BouncingScrollWrapper.builder(context, child!),
            breakpoints: const [
              Breakpoint(start: 0, end: 450, name: MOBILE),
              Breakpoint(start: 451, end: 800, name: TABLET),
              Breakpoint(start: 801, end: 1200, name: DESKTOP),
              Breakpoint(start: 1201, end: 2460, name: '4K'),
            ],
          ),
          initialRoute: AppRoutes.splashScreen,
          getPages: AppRoutes.pages,
        );
      },
    );
  }
}