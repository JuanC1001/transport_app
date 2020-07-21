import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:async';
import 'AppBar2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Provider.dart';

import 'package:provider/provider.dart';
import '../main.dart';

class Datos {
  final String origen;
  final String destino;
  final String fecha;

  Datos(this.origen, this.destino, this.fecha);
}

class Paso4 extends StatelessWidget {
  final heard2 = Heard2('images/confirmado2.jpg', 'Reserva Exitosa', '4', 0.8);

  String _value = '';

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2016),
        lastDate: new DateTime(2019));
  }
  _eliminarreserva(String codigo) async {
    Response respuestaeliminar = await get("http://informacion.somee.com/api/cooperativas/$codigo");
    var jsonData = json.decode(respuestaeliminar.body);
    //print(jsonData.toString());
    return jsonData;
  }
  String data;

  @override
  Widget build(BuildContext context) {
    final myProvider = Provider.of<MyProvider>(context);
    data=myProvider.miorigen+" " +myProvider.midestino+" "+ myProvider.mihoraSalida +" "+myProvider.mihoraLlegada+" "+ myProvider.micantidadAsientos.toString()+" "+ myProvider.minumeroAsientos.toString()+" "+myProvider.miTotal.toString();
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: myAppBar2(),
            backgroundColor: Colors.black,
            expandedHeight: 150.0,
            floating: false,
            pinned: true,
            snap: false,
            flexibleSpace: FlexibleSpaceBar(
              background: MyFlexiableAppBar2(
                heard2: heard2,
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate(<Widget>[
                //lista de listas
                Container(
                  padding: EdgeInsets.only(left: 30, top: 10, right: 30, bottom: 20),
                  //color: Colors.yellow,
                  child: Column(
                    children: <Widget>[
                      Text("COOPERATIVA TRANS VENCEDORES"),
                      Text(myProvider.miorigen+"-"+myProvider.midestino),
                      Text("02-07-2020"),
                      Text(myProvider.mihoraSalida+" - "+ myProvider.mihoraLlegada),
                      Text(myProvider.mitarifa.toString()),
                      Text("Bus # "),
                      Text("Cantidad boletos: "+ myProvider.micantidadAsientos.toString()),
                      Text("Asientos # " +myProvider.minumeroAsientos.toString()),
                      Text("Total " +myProvider.miTotal.toString()),
                      Text("Reservado", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), ),
                      SizedBox(height: 10,),
                      QrImage(
                        data: data,
                        size: 200,
                      ),
                      Text("Código QR de la reservación"),
                    ],
                  ),
                ),
              ]))
        ],
      ),
      persistentFooterButtons: <Widget>[
        Container(
          height: 50,
          width: 160,
          color: Colors.red,
          child: ListTile(
              title: Text(
                'CANCELAR',
                textAlign: TextAlign.end,
                style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.white70,
                    fontWeight: FontWeight.w700),
              ),
              trailing: Icon(
                Icons.cancel,
                color: Colors.white70,
              ),
              onTap: () {
                showDialog(
                    context: context,
                  barrierDismissible: false,
                  builder: (context)=>AlertDialog(
                    title: Text("CANCELAR RESERVA"),
                    content: Text("¿Está seguro que desea CANCELAR la reservación?"),
                    actions: <Widget>[
                      FlatButton(onPressed: (){
                        Navigator.of(context).pop();
                        Navigator.pushNamed(context, '/Reservas');
                      },
                          child: Text("SI")),
                      FlatButton(onPressed: (){
                        Navigator.of(context).pop();
                      },
                          child: Text("NO")),
                    ],
                  ),
                );
/*                if (keyForm.currentState.validate()) {
                  print("Nombre ${nombreCtrl.text}");
                  Navigator.pushNamed(context, '/Paso5');
                }*/
              }
          ),
        ),
        Container(
          height: 50,
          width: 170,
          color: Colors.lightGreen,
          child: ListTile(
              title: Text(
                ' COMPRAR ',
                textAlign: TextAlign.end,
                style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.white70,
                    fontWeight: FontWeight.w700),
              ),
              trailing: Icon(
                Icons.payment,
                color: Colors.white70,
              ),
              onTap: () {
                  Navigator.pushNamed(context, '/Paso5');
              }
          ),
        ),
      ],
    );
  }
}

class CustomPicker extends CommonPickerModel {
  String digits(int value, int length) {
    return '$value'.padLeft(length, "0");
  }

  CustomPicker({DateTime currentTime, LocaleType locale})
      : super(locale: locale) {
    this.currentTime = currentTime ?? DateTime.now();
    this.setLeftIndex(this.currentTime.hour);
    this.setMiddleIndex(this.currentTime.minute);
    this.setRightIndex(this.currentTime.second);
  }

  @override
  String leftStringAtIndex(int index) {
    if (index >= 0 && index < 24) {
      return this.digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String middleStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      return this.digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String rightStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      return this.digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String leftDivider() {
    return "|";
  }

  @override
  String rightDivider() {
    return "|";
  }

  @override
  List<int> layoutProportions() {
    return [1, 2, 1];
  }

  @override
  DateTime finalTime() {
    return currentTime.isUtc
        ? DateTime.utc(
        currentTime.year,
        currentTime.month,
        currentTime.day,
        this.currentLeftIndex(),
        this.currentMiddleIndex(),
        this.currentRightIndex())
        : DateTime(
        currentTime.year,
        currentTime.month,
        currentTime.day,
        this.currentLeftIndex(),
        this.currentMiddleIndex(),
        this.currentRightIndex());
  }
}

class datosPersonales extends StatefulWidget {
  @override
  mydatosPersonales createState() => mydatosPersonales();
}

class mydatosPersonales extends State<datosPersonales> {
  GlobalKey<FormState> keyForm = new GlobalKey();
  TextEditingController nombreCtrl = new TextEditingController();
  TextEditingController cedulaCtrl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //color: Colors.red,
        margin: new EdgeInsets.all(20.0),
        child: new Form(
          key: keyForm,
          child: formUI(),
        ),
      ),
      persistentFooterButtons: <Widget>[
        RaisedButton(
          onPressed: () {
            if (keyForm.currentState.validate()) {
              print("Nombre ${nombreCtrl.text}");
              Navigator.pushNamed(context, '/Paso4');
            }
          },
          color: Colors.amber,
          padding: const EdgeInsets.only(
              bottom: 10.0, top: 10.0, left: 50.0, right: 50.0),
          child: Row(
            children: <Widget>[
              Text(
                'CONTINUAR',
                textAlign: TextAlign.end,
                style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.white70,
                    fontWeight: FontWeight.w700),
              ),
              Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget formUI() {
    return Column(
      children: <Widget>[
        TextFormField(
          controller: cedulaCtrl,
          decoration: new InputDecoration(
            icon: Icon(
              Icons.fingerprint,
              color: Colors.blue[900],
            ),
            labelText: 'Cédula: ',
          ),
          maxLength: 10,
          validator: validateCedula,
        ),
        TextFormField(
          controller: nombreCtrl,
          decoration: new InputDecoration(
            icon: Icon(
              Icons.person,
              color: Colors.blue[900],
            ),
            labelText: 'Nombres y Apellidos:',
          ),
          maxLength: 30,
          validator: validateName,
        ),
      ],
    );
  }

  String validateName(String value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "El Nombre es necesario";
    } else if (!regExp.hasMatch(value)) {
      return "El Nombre debe de ser a-z y A-Z";
    }
    return null;
  }

  String validateApellido(String value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "El Apellido es necesario";
    } else if (!regExp.hasMatch(value)) {
      return "El Apellido debe de ser a-z y A-Z";
    }
    return null;
  }

  String validateCedula(String value) {
    String pattern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "La cedula es necesaria";
    } else if (!regExp.hasMatch(value)) {
      return "La cedula debe de ser a-z y A-Z";
    }
    return null;
  }

  String validateMobile(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "El Teléfono es necesario";
    } else if (value.length != 10) {
      return "El número debe tener 10 digitos";
    }
    return null;
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "El correo es necesario";
    } else if (!regExp.hasMatch(value)) {
      return "Correo invalido";
    } else {
      return null;
    }
  }
}
