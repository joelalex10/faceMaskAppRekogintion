import 'package:AppRekognitionFaceMask/Pages/LoginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';


List<CameraDescription> camera;

Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value){
    runApp(MyApp());
  });
  camera = await availableCameras();

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Detector de Mascarillas',
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
