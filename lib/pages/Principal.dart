import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'AppBar.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';
import 'package:flutter/services.dart' show rootBundle;
import 'Provider.dart';

class Principal extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Principals();
}

class Principals extends State<Principal> {
  _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed('/Inicio');
  }
  Future getCurrentUser () async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user.email;
  }
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final heards = Heard('images/viaja.jpg', 'Descubre', 'descripcion2');
  @override
  List<DropdownMenuItem<int>> ListDrop = [];
  StreamController _streamController;
  Stream _stream;

  _buscarinformacion(String origen, String destino) async {
    if (origen != null && destino != null) {
      Response respuesta = await get(
          "http://informacion.somee.com/api/Informacions/InfoByOrigenDestino?origen=$origen&destino=$destino");
      var jsonData = json.decode(respuesta.body);
      _streamController.add(json.decode(respuesta.body));
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

  @override
  void initState() {
    super.initState();
    _streamController = StreamController();
    _stream = _streamController.stream;
  }

  Widget build(BuildContext context) {
    var myProvider = Provider.of<MyProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: myAppBar(),
            backgroundColor: Colors.black,
            expandedHeight: 150.0,
            floating: true,
            pinned: true,
            snap: false,
            flexibleSpace: FlexibleSpaceBar(
              background: MyFlexiableAppBar(
                heard: heards,
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate(<Widget>[
            //lista de listas
            Container(
              color: Colors.amberAccent,
              child: ListTile(
                  title: Text(
                    'COMPRAR O RESERVAR UN VIAJE',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black54,
                      //fontFamily: 'Poppins',
                      fontSize: 14.0,
                    ),
                  ),
                  leading: Icon(
                    Icons.card_travel,
                    color: Colors.blueGrey[900],
                    //size: 28.0,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.blueGrey[900],
                    //size: 28.0,
                  ),
                  onTap: () => Navigator.pushNamed(context, '/Paso1')),
            ),
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
                    //color: Colors.black12,
                    child: mydropDestino(),
                  ),
                ],
              ),
            ),
            RaisedButton(
              onPressed: () {
                _buscarinformacion(myProvider.miorigen, myProvider.midestino);
              },
              color: Colors.white70,
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
            Divider(height: 2),
            StreamBuilder(
              stream: _stream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                //print("___________imprimiento data____________");
                // print(snapshot.data);
                if (snapshot.data != null) {
                  if (snapshot.data["status"] != 404) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Material(
                          color: Colors.white,
                          shadowColor: Colors.black26,
                          child: ListTile(
                            title: Text('DISTANCIA',
                                style: TextStyle(fontWeight: FontWeight.w500)),
                            subtitle: Text('Puede variar según la ruta '),
                            leading: Icon(
                              Icons.swap_calls,
                              color: Colors.black,
                            ),
                            trailing: Text(
                              snapshot.data["distanciaInformacion"],
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ),
                        Divider(height: 2),
                        Material(
                          color: Colors.white,
                          shadowColor: Colors.black26,
                          child: ListTile(
                            title: Text('TIEMPO',
                                style: TextStyle(fontWeight: FontWeight.w500)),
                            subtitle: Text('Puede variar según el tráfico'),
                            leading: Icon(
                              Icons.timer,
                              color: Colors.black,
                            ),
                            trailing: Text(
                              snapshot.data["tiempoInformacion"],
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ),
                        Divider(height: 2),
                        Material(
                          color: Colors.white,
                          shadowColor: Colors.black26,
                          child: ListTile(
                            title: Text('EMPRESAS',
                                style: TextStyle(fontWeight: FontWeight.w500)),
                            subtitle: Text('Información disponible'),
                            leading: Icon(
                              Icons.directions_bus,
                              color: Colors.black,
                            ),
                            trailing: Text(
                              snapshot.data["empresasInformacion"].toString(),
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ),
                        Divider(height: 2),
                        Material(
                          color: Colors.white,
                          shadowColor: Colors.black26,
                          child: ListTile(
                            title: Text('TARIFA',
                                style: TextStyle(fontWeight: FontWeight.w500)),
                            subtitle: Text('Puede variar según la temporada '),
                            leading: Icon(
                              Icons.attach_money,
                              color: Colors.black,
                            ),
                            trailing: Text(
                              snapshot.data["tarifaInformacion"].toString(),
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ),
                        Divider(height: 2),
                        Material(
                          color: Colors.white,
                          elevation: 5.0,
                          shadowColor: Colors.black26,
                          child: ListTile(
                            title: Text('NOTA:',
                                style: TextStyle(fontWeight: FontWeight.w500)),
                            subtitle: Text(
                                'Los horarios o tarifas de pasajes pueden variar especialmente durante la temporada festival y feriados. '),
                            leading: Icon(
                              Icons.event_note,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Divider(height: 5, color: Colors.white),
                      ],
                    );
                  } else {
                    print(
                        "_______________data is null falso_____________________");
                    return Center(
                      heightFactor: 10,
                      child: Text(
                        "No hay datos Disponibles",
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                } else {
                  return Center(
                    heightFactor: 10,
                    child: Text(
                      "Selecciona un ORIGEN y un DESTINO y descubre información relevante que te puede ayudar para tu viaje",
                      textAlign: TextAlign.center,
                    ),
                  );
                }
              },
            ),
          ]))
        ],
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            new DrawerHeader(
                //new UserAccountsDrawerHeader(
                //accountName: new Text("Juan Carlos Malca"),
                //accountEmail: new Text("juancarlosmalca2@gmail.com"),
                //currentAccountPicture: CircleAvatar(
                // backgroundImage: NetworkImage("https://0.academia-photos.com/97226744/25929890/24580983/s200_juan_carlos.malca.jpg"),
                //),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Material(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        elevation: 10,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Image.asset('images/logo.jpg',
                              width: 80, height: 80),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: FutureBuilder(
                          future: getCurrentUser(),
                          builder: (BuildContext context, AsyncSnapshot snapshot){
                            if(snapshot.data==null){
                              return Container(
                                  child: Text("No existe usuario")
                              );
                            }else{
                              print(snapshot.data);
                              return Container(
                                  child: Text(snapshot.data)
                              );
                            }
                          },
                        ),
                      )
                    ],
                  ),
                )),
            ListTile(
              leading: new Icon(Icons.help_outline),
              title: new Container(
                child: new Row(
                  children: <Widget>[
                    Text(
                      'Ayuda',
                    )
                  ],
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            new Divider(),
            ListTile(
              leading: Icon(Icons.arrow_back),
              title: new Container(
                child: new Row(
                  children: <Widget>[
                    Text('Mis Reservaciones'),
                  ],
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/Reservas');
              },
            ),
            new Divider(),
            ListTile(
              leading: Icon(Icons.arrow_back),
              title: new Container(
                child: new Row(
                  children: <Widget>[
                    Text('Cerrar Sesión'),
                  ],
                ),
              ),
              onTap: () {
                _logout();
              },
            ),
            new Divider(),
          ],
        ),
      ),
    );
  }
}

class mydropOrigen extends StatefulWidget {
  mydropOrigen({Key key}) : super(key: key);

  @override
  myOrigen createState() => myOrigen();
}

/*class myOrigen extends State<mydropOrigen> {
  String dropdownValue = 'Riobamba';
  @override
  Widget build(BuildContext context) {
    var myProvider = Provider.of<MyProvider>(context);

    return DropdownButton<String>(
      hint: new Text('Origen'),
      value: myProvider.miorigen,
      //iconSize: 30,
      elevation: 8,
      style: TextStyle(color: Colors.grey, fontSize: 18.0),
      underline: Container(
        height: 1,
        color: Colors.white,
      ),
      items: <String>['Riobamba'].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
          myProvider.miorigen = dropdownValue;
        });
      },
    );
  }
}*/
class myOrigen extends State<mydropOrigen> {
  var dropvalue = null;

  @override
  void initState() {
    super.initState();
    getDataOrigen();
  }

  List listaorigen;
  List data; //edited line
  Future<List> getDataOrigen() async {
    var respuesta;
    final response = await http.get(
        Uri.encodeFull("http://informacion.somee.com/api/Origens"),
        headers: {"Accept": "application/json"});
    setState(() {
      respuesta = json.decode(response.body);
      listaorigen = respuesta;
    });
    //print(respuesta);
    //print(listaorigen.length);
    Destinando();
  }

  Map<int, String> ListarOrigenM = Map();

  void Destinando() {
    for (var i = 0; i < listaorigen.length; i++) {
      ListarOrigenM[listaorigen[i]['idOrigen']] =
          listaorigen[i]['nombreOrigen'];
    }
    //dropvalue = ListarOrigenM[listorigen[0]['idorigen']];
  }

  @override
  Widget build(BuildContext context) {
    var myProvider = Provider.of<MyProvider>(context);
    return DropdownButton<String>(
      hint: new Text('Origen'),
      value: myProvider.miorigen,
      elevation: 8,
      style: TextStyle(color: Colors.grey, fontSize: 18.0),
      underline: Container(
        height: 1,
        color: Colors.white,
      ),
      items: ListarOrigenM.values.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(fontSize: 10.0),
          ),
        );
      }).toList(),
      onChanged: (String newValue) {
        setState(() {
          //dropvalue = newValue;
          myProvider.miorigen = newValue;
          //print(myProvider.miorigen);
        });
      },
    );
  }
}

class mydropDestino extends StatefulWidget {
  mydropDestino({Key key}) : super(key: key);

  @override
  myDestino createState() => myDestino();
}

class myDestino extends State<mydropDestino> {
  var dropvalue = null;

  @override
  void initState() {
    super.initState();
    getDataDestino();
  }

  List listadestino;
  List data; //edited line
  Future<List> getDataDestino() async {
    var respuesta;
    final response = await http.get(
        Uri.encodeFull("http://informacion.somee.com/api/Destinos"),
        headers: {"Accept": "application/json"});
    setState(() {
      respuesta = json.decode(response.body);
      listadestino = respuesta;
    });
    //print(respuesta);
    //print(listadestino.length);
    Destinando();
  }

  Map<int, String> ListarDestinoM = Map();

  void Destinando() {
    for (var i = 0; i < listadestino.length; i++) {
      ListarDestinoM[listadestino[i]['idDestino']] =
          listadestino[i]['nombreDestino'];
    }
    //dropvalue = ListarDestinoM[listadestino[0]['idDestino']];
  }

  @override
  Widget build(BuildContext context) {
    var myProvider = Provider.of<MyProvider>(context);
    return DropdownButton<String>(
      hint: new Text('Destino'),
      value: myProvider.midestino,
      elevation: 8,
      style: TextStyle(color: Colors.grey, fontSize: 18.0),
      underline: Container(
        height: 1,
        color: Colors.white,
      ),
      items:
          ListarDestinoM.values.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(fontSize: 10.0),
          ),
        );
      }).toList(),
      onChanged: (String newValue) {
        setState(() {
          //dropvalue = newValue;
          //_nombredestino=newValue;
          myProvider.midestino = newValue;
          //print(myProvider.midestino);
        });
      },
    );
  }
}

class Destins {
  final int id_destino;
  final String nombre_destino;

  Destins(this.id_destino, this.nombre_destino);
}

class Destino {
  final int id_destino;
  final String nombre_destino;

  Destino({this.id_destino, this.nombre_destino});

  factory Destino.fromJson(Map<String, dynamic> json) {
    return Destino(
      id_destino: json['id_destino'] as int,
      nombre_destino: json['nombre_destino'] as String,
    );
  }
}

class Informacion {
  final int id_informacion;
  final int id_origen;
  final int id_destino;
  final String distancia_informacion;
  final String tiempo_informacion;
  final int empresas_informacion;
  final double tarifa_informacion;

  Informacion({
    this.id_informacion,
    this.id_origen,
    this.id_destino,
    this.distancia_informacion,
    this.tiempo_informacion,
    this.empresas_informacion,
    this.tarifa_informacion,
  });

  factory Informacion.fromJson(Map<String, dynamic> json) {
    return Informacion(
      id_informacion: json['idInformacion'] as int,
      id_origen: json['idOrigen'] as int,
      id_destino: json['idDestino'] as int,
      distancia_informacion: json['distanciaInformacion'] as String,
      tiempo_informacion: json['tiempoInformacion'] as String,
      empresas_informacion: json['empresasInformacion'] as int,
      tarifa_informacion: json['tarifaInformacion'] as double,
    );
  }
}

/*Future<Destino> fetchPost() async {
  final response = await http.get('https://jsonplaceholder.typicode.com/posts/1');

  if (response.statusCode == 200) {
    // Si la llamada al servidor fue exitosa, analiza el JSON
    return Destino.fromJson(json.decode(response.body));
  } else {
    // Si la llamada no fue exitosa, lanza un error.
    throw Exception('Failed to load post');
  }
}*/
/*Future<String> _loadProductAsset() async {
*/ /*
  final response = await http.get('https://jsonplaceholder.typicode.com/posts/1');
*/ /*
  return await rootBundle.loadString('http://informacion.somee.com/api/destinos');

}
Future loadDestino() async{
  String jsonDestino =await _loadProductAsset();
  final jsonResponse = json.decode(jsonDestino);
  Destino product = new Destino.fromJson(jsonResponse);
  //print(product.nombre_destino);
}*/

class HttpService {
  final String postsURL = "http://informacion.somee.com/api/Destinos";

  Future<List<Destino>> getPosts() async {
    Response res = await get(postsURL);
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Destino> posts =
          body.map((dynamic item) => Destino.fromJson(item)).toList();
      return posts;
    } else {
      throw "Can't get posts.";
    }
  }
}

class HttpService1 {
  final String postsURL = "http://informacion.somee.com/api/informacions";

  Future<List<Informacion>> getPosts() async {
    Response res = await get(postsURL);
    if (res.statusCode == 200) {
      print(res.body);
      List<dynamic> body = jsonDecode(res.body);
      List<Informacion> posts =
          body.map((dynamic item) => Informacion.fromJson(item)).toList();
      return posts;
    } else {
      throw "Can't get posts.";
    }
  }
}

/* SizedBox(
                  height: 100,
                  child: FutureBuilder(
                    future: httpService1.getPosts(),
                    builder: (BuildContext context, AsyncSnapshot<List<Informacion>> snapshot) {
                      if (snapshot.hasData) {
                        List<Informacion> infos = snapshot.data;
                        return ListView(
                          children: infos.map((Informacion info) =>
                              ListTile(
                                subtitle: Text("${info.id_destino}"),
                                title: Text(info.distancia_informacion,
                                    style:
                                    TextStyle(
                                        color: Colors.black87,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                                leading: Icon(
                                  Icons.directions_bus,
                                  color: Colors.blue[900],
                                ),
                                trailing: SizedBox(
                                    height: 50,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text("${info.tarifa_informacion}",
                                          style: const TextStyle(
                                              fontSize: 12.0,
                                              color: Color(0xFF203573),
                                              fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(
                                          height: 20,
                                          child: RaisedButton(
                                            color: Colors.amber,
                                            onPressed: () {
                                              //Navigator.pushNamed(context, '/Paso2');
                                            },
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => Paso2(
                                      info2: info,
                                    ),
                                  ),
                                ),
                              ),
                          ).toList(),
                        );
                      } else {
                        return Center(
                            child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),*/

/* final String url = "http://informacion.somee.com/api/Destinos";
  List data; //edited line
  Future<String> getSWData() async {
    var res = await http.get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);
    setState(() {
      data = resBody;
    });
    //print("resBody");
    //print(resBody);
    print("data");
    print(data);
    return "Sucess";
  }*/
/*Future<List<Destins>> _getDestins() async{
    var data=await http.get("http://informacion.somee.com/api/Destinos");
    var jsonData=json.decode(data.body);
    List<Destins> destinos=[];
    for(var u in jsonData){
      Destins destino=Destins(u["id_destino"], u["nombre_destino"]);
      destinos.add(destino);
    }
    print(destinos.length);
    return destinos;
  }*/

/*  List<DropdownMenuItem<int>> ListDrop=[];
  int _mySelectionDestino=1;
  void loadData() {
    ListDrop=[];
    ListDrop.addAll(data.map((item) {
    }).toList());
*/ /*    ListDrop.add(new DropdownMenuItem(
      child: new Text('Quito'),
      value: 2,

            child: new Text(item['nombre_destino']);
      value: item['id_destino'].toString();
    ));*/ /*
  }*/
/*  @override
  Widget build(BuildContext context) {
    //loadData();
    var myProvider = Provider.of<MyProvider>(context);
    _mySelection=myProvider.midestino;
   return FutureBuilder(
     future: _getDestins(),
     builder: (BuildContext context, AsyncSnapshot snapshot){
       if(snapshot.data==null){
      return Container(
      child: Text("Loading..")
      );
       }else{
         return ListView.builder(
           itemCount: snapshot.data.length,
             itemBuilder: (BuildContext context, int index){
             return ListTile(
               title: Text(snapshot.data[index].nombre_destino),
             );
             }
         );
       }

     },
   );
  }*/
