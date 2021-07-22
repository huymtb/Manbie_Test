import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manabie_testing/app/manabie_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MaterialApp(
      home: ManabieApp(),
      debugShowCheckedModeBanner: false,
    ));
  });
}
