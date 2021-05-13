import 'package:AppRekognitionFaceMask/Pages/HomePage.dart';
import 'package:AppRekognitionFaceMask/Pages/LoginPage.dart';
import 'package:AppRekognitionFaceMask/Pages/SplashScreenPage.dart';
import 'package:flutter/material.dart';


class MainMenuPage extends StatefulWidget{
  @override
  _MainMenuPage createState() => _MainMenuPage();
}

class _MainMenuPage extends State<MainMenuPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MENU PRINCIPAL'),
        backgroundColor: Color(0xbb0C1232),
      ),
      body: Container(
        padding: EdgeInsets.all(50.0),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0x665ac18e),
                Color(0x995ac18e),
                Color(0xcc5ac18e),
                Color(0xff5ac18e),



              ]
          ),
        ),

        child: GridView.count(
          crossAxisCount: 1,
          children: <Widget>[
            cardoption('Monitorizacion',Icons.add_chart, HomePage(), context),

            cardoption('Ver Reportes',Icons.article, SplashScreenPage(), context),
            cardoption('Cerrar Sesion',Icons.logout, LoginPage(), context)
          ],

        ),
      ),
    );
  }

  Widget cardoption(String nombre, IconData iconData, StatefulWidget statefulWidget, BuildContext context){
    return Card(
      margin: EdgeInsets.all(6.0),
      child: InkWell(
        onTap: (){
          if(statefulWidget.toString() == LoginPage().toString()){
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Cerrar Sesion'),
                  content: Text('ESTA SEGURO DE CERRAR SESION'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Aceptar'),
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => statefulWidget,
                        ));

                      },
                    ),
                    FlatButton(
                      child: Text('Cancelar'),
                      onPressed: (){
                        Navigator.of(context).pop('Cancel');
                      },
                    ),
                  ],

                ),
            );
            
            debugPrint("MENSAJE DE ALERTA");
          }else{
            debugPrint("MENSAJE DE salida");
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => statefulWidget,
            ));
          }

        },
        splashColor: Color(0x665ac18e),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(iconData, size: 70.0,),
              Text(
                nombre,
                style: TextStyle(fontSize: 17.0),
              )
            ],
          ),
        ),
      ),
    );
  }


}