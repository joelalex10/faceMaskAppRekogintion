

import 'package:AppRekognitionFaceMask/Models/User.dart';
import 'package:AppRekognitionFaceMask/Pages/LoginPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as FA;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpPage extends StatefulWidget{

  @override
  _SignUpPage createState() => _SignUpPage();

}

class _SignUpPage extends State<SignUpPage>{


  TextEditingController nameText = TextEditingController();
  TextEditingController lastNameText = TextEditingController();
  TextEditingController emailText = TextEditingController();
  TextEditingController passwordText = TextEditingController();
  TextEditingController passwordConfirmText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('REGISTRO DE USUARIOS'),
        backgroundColor: Color(0xbb0C1232),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xff5ac18e),
                        Color(0xcc5ac18e),
                        Color(0x995ac18e),
                        Color(0x665ac18e),

                      ]
                  ),
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal:25,
                    vertical:0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 50,),
                      buildName(),
                      SizedBox(height: 20,),
                      buildLastName(),
                      SizedBox(height: 20,),
                      buildEmail(),
                      SizedBox(height: 20,),
                      buidPassword('Contraseña','Ingrese la contraseña',passwordText),
                      SizedBox(height: 20,),
                      buidPassword('Confirmacion de Contraseña','Confirme la contraseña',passwordConfirmText),
                      SizedBox(height: 20,),
                      buildSingUpConfirm(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: TextStyle(
            color: Colors.white,
            fontSize: 13,

          ),
        ),
        SizedBox(height: 10,),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 6,
                  offset: Offset(0,2),
                ),
              ]
          ),
          height: 60,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.black87,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top:14),
              prefixIcon: Icon(
                Icons.email,
                color: Color(0xff5ac18e),
              ),
              hintText: 'Email',
              hintStyle: TextStyle(
                color: Colors.black38,
              ),
            ),
            controller: emailText,
          ),
        ),
      ],
    );
  }


  Widget buildName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Nombre',
          style: TextStyle(
            color: Colors.white,
            fontSize: 13,

          ),
        ),
        SizedBox(height: 10,),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 6,
                  offset: Offset(0,2),
                ),
              ]
          ),
          height: 60,
          child: TextField(
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                color: Colors.black87,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top:14),
                prefixIcon: Icon(
                  Icons.person,
                  color: Color(0xff5ac18e),
                ),
                hintText: 'Ingrese sus nombres',
                hintStyle: TextStyle(
                  color: Colors.black38,
                ),
              ),
            controller: nameText,
          ),
        ),
      ],
    );
  }

  Widget buildLastName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Apellidos',
          style: TextStyle(
            color: Colors.white,
            fontSize: 13,

          ),
        ),
        SizedBox(height: 10,),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 6,
                  offset: Offset(0,2),
                ),
              ]
          ),
          height: 60,
          child: TextField(
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                color: Colors.black87,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top:14),
                prefixIcon: Icon(
                  Icons.person,
                  color: Color(0xff5ac18e),
                ),
                hintText: 'Ingrese sus apelldos',
                hintStyle: TextStyle(
                  color: Colors.black38,
                ),
              ),
            controller: lastNameText,
          ),
        ),
      ],
    );
  }

  Widget buidPassword(String text, String hintText, TextEditingController passwordText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 13,

          ),
        ),
        SizedBox(height: 10,),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 6,
                  offset: Offset(0,2),
                ),
              ]
          ),
          height: 60,
          child: TextField(
            obscureText: true,
            style: TextStyle(
              color: Colors.black87,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top:14),
              prefixIcon: Icon(
                Icons.lock,
                color: Color(0xff5ac18e),
              ),
              hintText: hintText,
              hintStyle: TextStyle(
                color: Colors.black38,
              ),
            ),
            controller: passwordText,
          ),
        ),
      ],
    );
  }

  Widget buildSingUpConfirm(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical:25),
      width: double.infinity,

      child: RaisedButton(
        elevation:5,
        onPressed: () async {
          /**
              Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MainMenuPage(),
              ));*/

          if(passwordText.text == passwordConfirmText.text){

            String name = nameText.text;
            String lastName = lastNameText.text;
            String email = emailText.text;
            String password = passwordText.text;


            User user = User(name, lastName, email, password);
            createUserData(user);

            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('REGISTRO CORRECTO'),
                content: Text('Se ha registrado a nuevo usuario'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('OK'),
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ));
                    },
                  ),
                ],

              ),
            );


          }else{
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Error'),
                content: Text('Las contraseñas deben ser iguales'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Cancelar'),
                    onPressed: (){
                      Navigator.of(context).pop('Cancel');
                    },
                  ),
                ],

              ),
            );
          }
        },
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Color(0xbb0C1232),
        child: Text(
          'REGISTRAR',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }



  void createUserData(User user){

    FirebaseFirestore.instance
        .collection('users')
        .add({
      'name': user.name,
      'lastName':user.lastName,
      'email': user.email,
      'password': user.password,

    });
  }

}