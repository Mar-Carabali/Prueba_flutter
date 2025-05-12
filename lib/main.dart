import 'package:flutter/material.dart';
import 'package:app_proyecto/screens/page/inicio.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: OnboardingScreen());
  }
}
