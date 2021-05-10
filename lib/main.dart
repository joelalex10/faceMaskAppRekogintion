import 'package:AppRekognitionFaceMask/SplashScreenPage.dart';
import 'package:AppRekognitionFaceMask/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

List<CameraDescription> camera;

Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  camera = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Detector de Mascarillas',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
