
import 'package:AppRekognitionFaceMask/Models/Alertas.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AlertasRepository{

  Future<List<Alerta>> getReportes() async{
    List<Alerta> localListAlertas = [];
    CollectionReference collectionReference =
    FirebaseFirestore.instance.collection("alertas");
    QuerySnapshot users = await collectionReference.get();

    if(users.docs.length != 0){

      for(var doc in users.docs){
        DateTime hora = doc.data()['hora'].toDate();
        String mensaje = doc.data()['mensaje'];
        Alerta alerta = Alerta(hora, mensaje);
        localListAlertas.add(alerta);
      }
    }else{
      debugPrint("NO HAY DATOS");
    }
    return localListAlertas;
  }

  Future<List<Alerta>> getReportesByData(DateTime dateTime) async {

    List<Alerta> localListAlertas = [];
    var dateInit = new DateTime(dateTime.year, dateTime.month, dateTime.day,0,0,0);
    var dateEnd = new DateTime(dateTime.year, dateTime.month, dateTime.day,23,59,59);

    final QuerySnapshot users = await FirebaseFirestore.instance.collection("alertas")
    //.where('hora', isLessThanOrEqualTo: dateTime)
        .where('hora', isLessThanOrEqualTo: dateEnd)
        .where('hora', isGreaterThanOrEqualTo: dateInit)
        .get();
    print("HAY DATOS: "+users.docs.length.toString());
    if(users.docs.length != 0){

      for(var doc in users.docs){
        DateTime hora = doc.data()['hora'].toDate();
        String mensaje = doc.data()['mensaje'];
        Alerta alerta = Alerta(hora, mensaje);
        localListAlertas.add(alerta);
      }
    }else{
      debugPrint("NO HAY DATOS");
    }
    return localListAlertas;
  }
}