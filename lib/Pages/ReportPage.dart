
import 'package:AppRekognitionFaceMask/Models/Alertas.dart';
import 'package:AppRekognitionFaceMask/Repository/AlertasRepository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReportPage extends StatefulWidget{

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage>{

  DateTime _dateTime = DateTime.now();
  String hintTextSearch = 'Ingrese una fecha';
  List<Alerta> listAlertas = [];
  AlertasRepository _alertasRepository;
  DateTime _datePicker;
  //TextEditingController dateTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('REPORTES'),
        backgroundColor: Color(0xbb0C1232),
      ),
      body: Container(
        padding: EdgeInsets.all(25.0),
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

        child: Column(
          children: <Widget>[
            buidSearch(),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: listaElementos(),
            ),
          ],

        ),
      ),
    );


  }

  Widget buidSearch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Buscar por fecha',
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
          child: TextFormField(
            keyboardType: TextInputType.datetime,
            readOnly: true,
            style: TextStyle(
              color: Colors.black87,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top:14),
              prefixIcon: Icon(
                Icons.date_range,
                color: Color(0xff5ac18e),
              ),
              hintText: hintTextSearch,
              hintStyle: TextStyle(
                color: Colors.black38,
              ),
            ),
            onTap: (){
              setState(() {
                _selectDate(context);

              });
            },
          ),
        ),
      ],
    );
  }

  Future<Null> _selectDate(BuildContext context) async{
    _datePicker = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(1970),
        lastDate: DateTime(2045),
    );

    if(_datePicker != null && _datePicker != _dateTime){
      setState(() {
        _dateTime = _datePicker;
        String year = _dateTime.year.toString();
        String month = _dateTime.month.toString();
        String day = _dateTime.day.toString();
        hintTextSearch =year +" / "+month + " / "+day;
        
        listAlertas.clear();
        _alertasRepository = AlertasRepository();
        _alertasRepository.getReportesByData(_datePicker).then((value){
          setState(() {
            listAlertas.addAll(value);
          });
        });
        
      });

    }

  }
  @override
  void initState() {

    super.initState();
    _alertasRepository = AlertasRepository();
    _alertasRepository.getReportes().then((value){
      setState(() {
        listAlertas.addAll(value);
      });
    });
    print("DEFINITIVO");
    print("la lista es: "+listAlertas.toString());







  }

  String addZero(String number){
    if(number.length<2){
      number='0'+number;
    }
    return number;
  }


  Widget listaElementos() {

    return ListView.builder(
      itemCount: listAlertas.length,
      itemBuilder: (BuildContext context, int index){

        String year = listAlertas[index].hora.year.toString();
        String month =addZero(listAlertas[index].hora.month.toString());
        String day = addZero(listAlertas[index].hora.day.toString());

        String date =year +"/"+month + "/"+day;

        String hour = addZero(listAlertas[index].hora.hour.toString());
        String minute = addZero(listAlertas[index].hora.minute.toString());
        String second = addZero(listAlertas[index].hora.second.toString());

        String hourComplete =hour +":"+minute + ":"+second;



        return Card(
          margin: EdgeInsets.all(6.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  date+" "+hourComplete,
                  style: TextStyle(fontSize: 17.0),
                ),
                Text(
                  listAlertas[index].mensaje,
                  style: TextStyle(fontSize: 11.0),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}