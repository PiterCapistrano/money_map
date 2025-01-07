import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:money_map/app.dart';
import 'package:money_map/firebase_options.dart';
import 'package:money_map/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setupDependencies();
  runApp(const App());
}
