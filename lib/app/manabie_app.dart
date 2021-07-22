import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manabie_testing/screen/main_screen.dart';

class ManabieApp extends StatefulWidget {
  const ManabieApp({Key? key}) : super(key: key);

  @override
  _ManabieAppState createState() => _ManabieAppState();
}

class _ManabieAppState extends State<ManabieApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: Get.key,
      home: const MainScreen(),
    );
  }
}
