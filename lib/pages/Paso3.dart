import 'dart:convert';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'AppBar2.dart';
import 'Provider.dart';

//import 'package:provider/provider.dart';
//import 'Provider.dart';
class Datos {
  final String origen;
  final String destino;
  final String fecha;

  Datos(this.origen, this.destino, this.fecha);
}

class Paso3 extends StatefulWidget {
  @override
  Paso03 createState() => Paso03();
}

class Paso03 extends State<Paso3> {
  GlobalKey<FormState> keyForm = new GlobalKey();
  TextEditingController nombreCtrl = new TextEditingController();
  TextEditingController direccionCtrl = new TextEditingController();
  TextEditingController cedulaCtrl = new TextEditingController();

//  bool boxValue=false;

  //final Destino posts;
  final heard2 =
      Heard2('images/facturacion.jpg', 'Datos de facturación', '3', 0.6);
  String _value = '';

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2016),
        lastDate: new DateTime(2019));
  }

  Future getCurrentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user.email;
  }

  _cooperativa(String codigo) async {
    Response respuestaviaje =
        await get("http://informacion.somee.com/api/cooperativas/$codigo");
    var jsonData = json.decode(respuestaviaje.body);
    //print(jsonData.toString());
    return jsonData;
  }

  @override
  Widget build(BuildContext context) {
    var myProvider = Provider.of<MyProvider>(context);
    DateTime now = DateTime.now();
    String fecha = formatDate(now, [dd, '-', mm, '-', yyyy]);
    String fecha2 = null;
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
              height: 40,
              padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
              child: TextFormField(
                style: TextStyle(fontSize: 11),
                //controller: direccionCtrl,
                decoration: new InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.calendar_today,
                    color: Colors.blue[900],
                    size: 15,
                  ),
                  labelText: 'Fecha:  ' + '$fecha',
                ),
                enabled: false,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
              alignment: Alignment.center,
              child: Text(
                "DATOS DEL CLIENTE",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: FutureBuilder(
                future: getCurrentUser(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(child: Text("No existe usuario"));
                  } else {
                    print(snapshot.data);
                    return Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                          height: 30,
                          child: TextFormField(
                            style: TextStyle(fontSize: 12),
                            decoration: new InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.person_pin,
                                color: Colors.blue[900],
                                size: 15,
                              ),
                              labelText:
                                  'Nombres y Apellido :  ' + snapshot.data,
                            ),
                            enabled: false,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                          height: 30,
                          child: TextFormField(
                            style: TextStyle(fontSize: 12),
                            //controller: direccionCtrl,
                            decoration: new InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.blue[900],
                                size: 15,
                              ),
                              labelText: 'Email:  ' + snapshot.data,
                            ),
                            enabled: false,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                          height: 30,
                          child: TextFormField(
                            style: TextStyle(fontSize: 12),
                            decoration: new InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.fingerprint,
                                color: Colors.blue[900],
                                size: 15,
                              ),
                              labelText: 'Cédula: 0604632893',
                            ),
                            enabled: false,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                          height: 30,
                          child: TextFormField(
                            style: TextStyle(fontSize: 12, color: Colors.black),
                            decoration: new InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.phone,
                                color: Colors.blue[900],
                                size: 15,
                              ),
                              labelText: 'Teléfono: 0992788894',
                            ),
                            enabled: false,
                          ),
                        ),

                        Form(
                            key: keyForm,
                            child: Container(
                              padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                              height: 60,
                              child: TextFormField(
                                //maxLines: 2,
                                style: TextStyle(fontSize: 11),
                                controller: direccionCtrl,
                                validator: validateName,
                                //maxLength: 50,
                                decoration: new InputDecoration(
                                  //isDense: true,
                                  //contentPadding: EdgeInsets.all(5),
                                  errorStyle: TextStyle(fontSize: 12),
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(
                                    Icons.edit_location,
                                    color: Colors.blue[900],
                                    size: 15,
                                  ),
                                  labelText: 'Dirección',
                                  helperText: "Ingrese una direccion referencial de su domicilio",
                                ),
                                //enabled: false,
                              ),
                            ),
                        ),

                      ],
                    );
                  }
                },
              ),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
              alignment: Alignment.center,
              child: Text(
                "DATOS DEL BOLETO DE VIAJE",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
              //color: Colors.cyan,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              'Origen:  ',
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: Text(myProvider.miorigen),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              'Hora Salida:',
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: Text(myProvider.mihoraSalida),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              'Empresa:  ',
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: FutureBuilder(
                                  future:
                                      _cooperativa(myProvider.micooperativa),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(
                                        snapshot.data["nombreCooperativa"]
                                            .toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      );
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  }),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              'Destino:  ',
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: Text(myProvider.midestino),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              'Hora llegada:  ',
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: Text(myProvider.mihoraLlegada),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              'Tarifa:  ',
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: Text(myProvider.mitarifa.toString()),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.black12,
              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: Row(
                children: <Widget>[
                  Container(
                    child: Text('Cantidad',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    width: 80,
                  ),
                  Expanded(
                      child: Container(
                    child: Text('N° de asiento(s):',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  )),
                  Container(
                    child: Text('Total',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            Container(
              //color: Colors.black12,
              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),

              child: Row(
                //crossAxisAlignment: CrossAxisAlignment.center,
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(myProvider.micantidadAsientos.toString()),
                    width: 80,
                  ),
                  Expanded(
                      child: Container(
                    child: Text(myProvider.minumeroAsientos.toString()),
                  )),
                  Container(
                    child: Text(myProvider.miTotal.toString()),
                  ),
                ],
              ),
            ),
          ]))
        ],
      ),
      persistentFooterButtons: <Widget>[
        Container(
          alignment: Alignment.center,
          height: 50,
          width: 300,
          color: Colors.lightGreen,
          child: ListTile(
              title: Text(
                'CONFIRMAR  RESERVA',
                textAlign: TextAlign.right,
                style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.white70,
                    fontWeight: FontWeight.w700),
              ),
              trailing: Icon(
                Icons.save,
                color: Colors.white70,
              ),
              leading: Icon(
                Icons.verified_user,
                color: Colors.white70,
              ),
              onTap: () {
                //Navigator.pushNamed(context, '/Registro');
                if (keyForm.currentState.validate()) {
                //print("Nombre ${nombreCtrl.text}");
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/Paso4');
                }
              }),
        ),
      ],
    );
  }
}

String validateName(String value) {
  String pattern = r'(^[a-zA-Z ]*$)';
  RegExp regExp = new RegExp(pattern);
  if (value.length == 0) {
    return "Campo requerido";
  }
  return null;
}

String validateCedula(String value) {
  String pattern = r'(^[0-9]*$)';
  RegExp regExp = new RegExp(pattern);
  if (value.length == 0) {
    return "Campo requerido";
  } else if (!regExp.hasMatch(value)) {
    return "Cédula errónea";
  }
  return null;
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
