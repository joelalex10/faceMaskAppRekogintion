import 'dart:async';

import 'package:AppRekognitionFaceMask/Pages/SplashScreenPage.dart';
import 'package:AppRekognitionFaceMask/main.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:audioplayers/audioplayers.dart';


class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage>{
  // Define required instance
  CameraImage cameraImage;
  CameraController cameraController;
  // Define required variables
  bool isWorking = false;
  String result = '';

  bool isDetected = false;
  int contGlobal=0;

  int _counter = 10;
  Timer _timer;

  void _startTimer() {
    _counter = 10;
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  initCamera(){
    cameraController = CameraController(camera[0], ResolutionPreset.medium);
    cameraController.initialize().then((value){

      if(!mounted){
        return;
      }

      setState(() {
        cameraController.startImageStream((imageFromStream){
          if(!isWorking){
            isWorking=true;
            cameraImage=imageFromStream;
            runModelOnFrame();
          }

        });
      });
    });

  }

  loadModel() async {
    await Tflite.loadModel(model: "Assets/model_unquant.tflite",
        labels: "Assets/labels.txt");
  }

  void ejectFunction(recognitions){
    contGlobal++;
    print("EL CONTADOR GLOBAL ES: "+contGlobal.toString());
    print("LA VARIABLE TIENE ESTADOS: "+isDetected.toString());
    recognitions.forEach((response) {

      result += response["label"];
      print("estado: "+result);
      if(result.toString()=="0 Sin Barbijo"){
        print("SE HA DETECTADO A UNA PERTSONA SIN BARBIJO");
        isDetected=true;
      }

    });


  }

  runModelOnFrame() async{

    if(cameraImage != null){
      var recognitions = await Tflite.runModelOnFrame(
          bytesList: cameraImage.planes.map((plane) {
            return plane.bytes;
          }).toList(),
          imageHeight: cameraImage.height,
          imageWidth: cameraImage.width,
          imageMean: 127.5,
          imageStd: 127.5,
          rotation: 90,
          numResults: 1,
          threshold: 0.1,
          asynch: true
      );

      result = "";


      if(isDetected==false){
        ejectFunction(recognitions);


      }else{
        print("SE REPRODUCIRA EL AUDIO");
        final player = AudioCache();
        player.play("alarmClock.mp3");
        _startTimer();
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('ALERTA'),
            content: Text('Se ha detectado una persona sin barbijo'),
            actions: <Widget>[
              FlatButton(
                child: Text('Guardar Informacion'),
                onPressed: (){
                  debugPrint("SE HAN REGISTRADO LOS DATOS");


                  DateTime fechaActual= DateTime.now();
                  print("LA FECHA ES: "+fechaActual.toString());
                  FirebaseFirestore.instance
                      .collection('alertas')
                      .add({
                    'hora': fechaActual,
                    'mensaje': "SE HA DETECTADO UNA PERSONA SIN BARBIJO EN LA ENTRADA DEL ESTABLECIMIENTO",

                  });
                  ejectFunction(recognitions);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SplashScreenPage(),
                  ));
                  isDetected=false;
                },
              ),
              FlatButton(
                child: Text('Cancelar'),
                onPressed: (){
                  isDetected=false;
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SplashScreenPage(),
                  ));
                },
              ),
            ],

          ),
        );





      }
      setState(() {
        //result;
      });
      isWorking = false;

    }
  }

  @override
  void initState() {
    super.initState();
    initCamera();
    loadModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff5ac18e),
            title: result.isEmpty ? Text('ENFOQUE EL ROSTRO') :Text(result),
            /**Padding(padding: EdgeInsets.only(top: 30.0),
              child: Text(result,
                style: TextStyle(fontSize: 25,),
                textAlign: TextAlign.center,
              ),
            ),*/
            centerTitle: true,
          ),
          body: Container(
            child: (!cameraController.value.isInitialized)
                ?Container()
                :Align(
              alignment: Alignment.center,
              child: AspectRatio(
                aspectRatio: cameraController.value.aspectRatio,
                child: CameraPreview(cameraController),
              ),
            ),
          ),
          backgroundColor: Colors.black,
        );
  }


}