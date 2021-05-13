
import 'package:AppRekognitionFaceMask/Models/User.dart';
import 'package:AppRekognitionFaceMask/Pages/MainMenuPage.dart';
import 'package:AppRekognitionFaceMask/Pages/SignUpPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget{

  @override
  _LoginPage createState() => _LoginPage();

}

class _LoginPage extends State<LoginPage>{

  TextEditingController emailText = TextEditingController();
  TextEditingController passwordText = TextEditingController();
  List<User> listUsers;

  @override
  void initState(){
    listUsers = List<User>();
    super.initState();
    getUsers();

  }

  void getUsers() async{
    CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("users");
    QuerySnapshot users = await collectionReference.get();

    if(users.docs.length != 0){

      for(var doc in users.docs){
        String name = doc.data()['name'];
        String lastName = doc.data()['lastName'];
        String email = doc.data()['email'];
        String password = doc.data()['password'];
        User user = User(name, lastName, email, password);
        listUsers.add(user);
      }
    }else{
      debugPrint("NO HAY DATOS");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      Color(0xff5ac18e),

                    ]
                  ),
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal:25,
                    vertical:120,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'FACEMASK',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 50,),
                      buildEmail(),
                      SizedBox(height: 20,),
                      buildPassword(),
                      SizedBox(height: 70,),
                      buildLogInBtn(context),
                      SizedBox(height: 20,),
                      buidSignUp(),
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

  Widget buidSignUp(){
    return GestureDetector(
      onTap: (){
        debugPrint('REGRISTRO INICIADO');
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SignUpPage(),
        ));
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'No tiene una cuenta ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: 'Registrese',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]
        ),
    ),
    );
  }

  Widget buildLogInBtn(BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(vertical:25),
      width: double.infinity,

      child: RaisedButton(
        elevation:5,
        onPressed: (){

          bool isAcountExists = false;
          String email = emailText.text;
          String password = passwordText.text;


          for(var item in listUsers){
            if(item.email== email && item.password == password){
              isAcountExists=true;
            }
          }
          if(isAcountExists){
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MainMenuPage(),
                ));
          }else{
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Error'),
                content: Text('Los datos introducidos son incorrectos'),
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


          debugPrint(emailText.text);
          debugPrint(passwordText.text);


          debugPrint('INICIO DE SESION');
        },
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Color(0xbb0C1232),
        child: Text(
          'INICIO DE SESION',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget buildEmail(){
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
  Widget buildPassword(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
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
                hintText: 'Password',
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

}