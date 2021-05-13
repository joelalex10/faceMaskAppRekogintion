import 'package:AppRekognitionFaceMask/Pages/MainMenuPage.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';


class SplashScreenPage extends StatefulWidget{
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();

}

class _SplashScreenPageState extends State<SplashScreenPage>{
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: new MainMenuPage(),
      title: Text('Detector de Mascarillas',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 26, color: Colors.black
        ),
      ),
      image: Image.asset("Assets/proface.png"),
      photoSize: 170,
      backgroundColor: Colors.white,
      loaderColor: Color(0xff5ac18e),
      loadingText: Text('Cargando...', style: TextStyle(
        color: Colors.black,
        fontSize: 16.0
        ),
      textAlign: TextAlign.center,
      ),
    );
  }
}