import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'AppBar2.dart';
import 'Paso3.dart';
import 'Principal.dart';
import 'package:http/http.dart' as http;

import 'Provider.dart';

class Paso1 extends StatefulWidget {
  Paso1();

  @override
  State<StatefulWidget> createState() => _Paso1();
}

class _Paso1 extends State<Paso1> {
  String _value = '';
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2016),
        lastDate: new DateTime(2019));
  }

  final heard2 =
      Heard2('images/horarios.jpg', 'Busca tu mejor opción', '1', 0.2);
  final datosviaje = Datos('origen', 'destino', 'fecha');

  Future<List<Viaje>> _getViajes() async {
    var data = await http.get("http://informacion.somee.com/api/viajes");
    var jsonData = json.decode(data.body);
    print(data.body);
    List<Viaje> viajes = [];
    print(viajes.length);
    for (var viaj in jsonData) {
      Viaje via = Viaje(
          viaj['idViaje'],
          viaj['salidaViaje'],
          viaj['llegadaViaje'],
          viaj['tarifaViaje'],
          viaj['idOrigen'],
          viaj['idDestino'],
          viaj['idCooperativa']);
      print(via.llegadaViaje);
      viajes.add(via);
    }
    return viajes;
  }

  StreamController _streamControllerViajes;
  Stream _streamviajes;

  _buscar(String origen, String destino) async {
    print("origen");
    print(origen);
    if (origen != null && destino != null) {
      Response respuesta = await get(
          "http://informacion.somee.com/api/Viajes/GetViajes?origen=$origen&destino=$destino");
      // var jsonData =json.decode(respuesta.body);
      _streamControllerViajes.add(json.decode(respuesta.body));
    } else {
      _scaffoldKey.currentState.hideCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Seleccione un ORIGEN y un DESTINO"),
        duration: Duration(seconds: 5),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            _scaffoldKey.currentState.hideCurrentSnackBar();
          },
        ),
      ));
    }
  }

/*  _buscarviajes() async{
    Response respuestaviaje= await get("http://informacion.somee.com/api/viajes");
    _streamControllerViajes.add(json.decode(respuestaviaje.body));
  }*/
  _cooperativa(String codigo) async {
    Response respuestaviaje =
        await get("http://informacion.somee.com/api/cooperativas/$codigo");
    var jsonData = json.decode(respuestaviaje.body);
    //print(jsonData.toString());
    return jsonData;
  }

  @override
  void initState() {
    super.initState();
    _streamControllerViajes = StreamController();
    _streamviajes = _streamControllerViajes.stream;
  }

  @override
  Widget build(BuildContext context) {
    var myProvider = Provider.of<MyProvider>(context);
    DateTime now = DateTime.now();
    String fecha = formatDate(now, [dd, '-', mm, '-', yyyy]);
    return Scaffold(
      key: _scaffoldKey,
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
                color: Colors.white70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      'Fecha:',
                      style: TextStyle(fontSize: 10.0),
                    ),
                    //mySatefulCalendar(),
                    FlatButton(
                      onPressed: () {
                        DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime.now(),
                            maxTime: DateTime(2020, 12, 31),
                            theme: DatePickerTheme(
                                headerColor: Colors.white70,
                                backgroundColor: Colors.white,
                                itemStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                                doneStyle: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16)), onChanged: (date) {
                          //print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
                        }, onConfirm: (date) {
                          //print('confirm $date');
                          fecha = formatDate(date, [dd, '-', mm, '-', yyyy]);
                          print('confirmacion: $fecha');
                          return fecha;
                        }, currentTime: DateTime.now(), locale: LocaleType.es);
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Icon(
                                Icons.calendar_today,
                                color: Colors.black54,
                                size: 16.0,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              child: Text(
                                fecha + ' ',
                                style: const TextStyle(
                                    color: Colors.black54, fontSize: 14.0),
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black54,
                              size: 30,
                            ),
                          ]),
                    )
                  ],
                ),
              ),
              Divider(height: 2),
              Container(
                height: 60.0,
                color: Colors.white,
                padding: EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      width: 37,
                      child: Text(
                        'Origen:',
                        style: TextStyle(fontSize: 10.0),
                      ),
                    ),
                    Container(
                      child: mydropOrigen(),
                    ),
                    Container(
                      width: 37,
                      child: Text(
                        'Destino:',
                        style: TextStyle(fontSize: 10.0),
                      ),
                    ),
                    Container(
                      child: mydropDestino(),
                    ),
                  ],
                ),
              ),
              RaisedButton(
                onPressed: () {
                  _buscar(myProvider.miorigen, myProvider.midestino);
                },
                color: Colors.amberAccent,
                elevation: 0.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.search),
                    Text(
                      'BUSCAR',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontFamily: 'Poppins',
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 300,
                child: StreamBuilder(
                  stream: _streamviajes,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    //print(snapshot.data);
                    if (snapshot.data != null) {
                      return ListView.separated(
                        separatorBuilder: (context, index) =>
                            Divider(color: Colors.black12),
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            subtitle: Align(
                              alignment: Alignment.topLeft,
                              child: Column(
                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Salida: " +
                                        snapshot.data[index]["salidaViaje"],
                                    style: TextStyle(fontSize: 11),
                                  ),
                                  //Text(" "),
                                  Text(
                                    "Llegada: " +
                                        snapshot.data[index]["llegadaViaje"],
                                    style: TextStyle(fontSize: 11),
                                  ),
                                ],
                              ),
                            ),
                            title: FutureBuilder(
                                future: _cooperativa(snapshot.data[index]
                                        ["idCooperativa"]
                                    .toString()),
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
                            leading: Icon(
                              Icons.directions_bus,
                              color: Colors.blue[900],
                            ),
                            trailing: SizedBox(
                                //height: 50,
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Icon(
                                  Icons.attach_money,
                                  //color: Colors.amber,
                                ),
                                Text(
                                  snapshot.data[index]["tarifaViaje"]
                                      .toString(),
                                  style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            )),
                            onTap: () {
                              myProvider.micooperativa = snapshot.data[index]
                                      ["idCooperativa"]
                                  .toString();
                              myProvider.mihoraSalida =
                                  snapshot.data[index]["salidaViaje"];
                              myProvider.mihoraLlegada =
                                  snapshot.data[index]["llegadaViaje"];
                              myProvider.mitarifa =
                                  snapshot.data[index]["tarifaViaje"];
                              Navigator.pushNamed(context, '/Paso2');
                            },
                          );
                        },
                      );
                    } else {
                      return Center(
                        heightFactor: 10,
                        //CircularProgressIndicator();
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Selecciona un ORIGEN y un DESTINO",
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "BUSCA y elije una opción de VIAJE",
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ]),
          ),
        ],
      ),
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

class mySatefulCalendar extends StatefulWidget {
  mySatefulCalendar({Key key}) : super(key: key);

  @override
  myCalendar createState() => myCalendar();
}

class myCalendar extends State<mySatefulCalendar> {
  Future _selectDate() async {
    DateTime picked = await showDatePicker(
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2016),
        lastDate: new DateTime(2019));
  }

  //final datosviaje = Datos('origen', 'destino', 'fecha');
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String fecha = formatDate(now, [dd, '-', mm, '-', yyyy]);
    //String fecha2 = null;
    //var myProvider = Provider.of<MyProvider>(context);
    return FlatButton(
      onPressed: () {
        DatePicker.showDatePicker(context,
            showTitleActions: true,
            minTime: DateTime.now(),
            maxTime: DateTime(2020, 12, 31),
            theme: DatePickerTheme(
                headerColor: Colors.white70,
                backgroundColor: Colors.white,
                itemStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
                doneStyle: TextStyle(color: Colors.black54, fontSize: 16)),
            onChanged: (date) {
          //print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
        }, onConfirm: (date) {
          //print('confirm $date');
          fecha = formatDate(date, [dd, '-', mm, '-', yyyy]);
          print('confirmacion: $fecha');
          return fecha;
        }, currentTime: DateTime.now(), locale: LocaleType.es);
      },
      child:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        Container(
          child: Icon(
            Icons.calendar_today,
            color: Colors.black54,
            size: 16.0,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          child: Text(
            fecha + ' ',
            style: const TextStyle(color: Colors.black54, fontSize: 14.0),
          ),
        ),
        Icon(
          Icons.arrow_drop_down,
          color: Colors.black54,
          size: 30,
        ),
      ]),
    );
  }
}

class Viaje {
  final int idViaje;
  final String salidaViaje;
  final String llegadaViaje;
  final double tarifaViaje;
  final int idOrigen;
  final int idDestino;
  final int idCooperativa;

  Viaje(this.idViaje, this.salidaViaje, this.llegadaViaje, this.tarifaViaje,
      this.idOrigen, this.idDestino, this.idCooperativa);
}
