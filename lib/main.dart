import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(DynamicColorBuilder(
    builder: (lightDynamic, darkDynamic) => GetMaterialApp(
      title: "QRCode Generator",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(
        colorScheme: lightDynamic,
      ),
      darkTheme: ThemeData(
        colorScheme: darkDynamic,
      ),
    ),
  ));
}
