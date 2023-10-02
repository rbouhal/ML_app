import 'package:flutter/material.dart';
import 'package:ml_prototype/screens/camera_screen.dart';
import 'package:ml_prototype/screens/intro_screen.dart';
import 'package:ml_prototype/screens/aboutapp_screen.dart';

void main() {
  runApp(const GlobeApp());
}

class GlobeApp extends StatelessWidget {
  const GlobeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => IntroScreen(),
        '/camera': (context) => CameraScreen(),
        '/aboutapp': (context) => AboutAppScreen(),
      },
      initialRoute: '/',
      theme: ThemeData(primarySwatch: Colors.orange),
    );
  }
}
