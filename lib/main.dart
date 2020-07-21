import 'dart:collection';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' show AppBar, BuildContext, Center, Colors, Column, FloatingActionButton, Icon, Icons, Key, MainAxisAlignment, MaterialApp, Scaffold, State, StatefulWidget, StatelessWidget, Text, Theme, ThemeData, Widget, runApp;
import 'package:flutter/src/foundation/change_notifier.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:transport_app/pages/Inicio.dart';
import 'pages/Principal.dart';
import 'pages/SplashScreen.dart';
import 'pages/Paso1.dart';
import 'pages/Paso3.dart';
import 'pages/Paso4.dart';
import 'pages/Paso2.dart';
import 'pages/Prueba.dart';
import 'pages/Paso5.dart';
import 'pages/Paso6.dart';
import 'pages/Registro.dart';
import 'pages/Reservas.dart';
import 'package:provider/provider.dart';
import 'pages/Provider.dart';

ChangeNotifier variable;

//void main()=> runApp(new MyApps());
void main() {
  runApp(
    ChangeNotifierProvider(
      builder: (context) => MyProvider(),
      child: MyApps(),
    ),
  );
}

class MyApps extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=>_TodoInicio();
}
class _TodoInicio extends State<MyApps> {

Widget _rootpage= Inicio();
var _email;

  Future<Widget> getRootPage() async =>
      await FirebaseAuth.instance.currentUser()==null ? Inicio() : Principal();

  //_email=FirebaseAuth.instance.currentUser().;

  @override
  initState(){
super.initState();
getRootPage().then((Widget page){
  setState((){
    _rootpage=page;
  });
});
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        // Cuando naveguemos hacia la ruta "/", crearemos el Widget FirstScreen
        '/Inicio': (context) => Inicio(),
        '/Registro': (context) => RegisterPage(),
        '/Principal': (context) => Principal(),
        '/Paso1': (context) => Paso1(),
        '/Paso2': (context) => Paso2(),
        '/Paso3': (context) => Paso3(),
        '/Paso4': (context) => Paso4(),
        '/Paso5': (context) => Paso5(),
        '/Paso6': (context) => myDestinos(),
        '/Reservas': (context) => myReservas(),
        '/Prueba': (context) => MyApps(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      //home: MyHomePage(title: 'Flutter Demo Home Page'),
      home: _rootpage,
    );
  }
}


class CartModel extends ChangeNotifier {
  /// Estado privado del carrito.
  final List<String> _items = [];

  /// Una vista inmodificable de items en el carrito.
  UnmodifiableListView<String> get items => UnmodifiableListView(_items);

  /// El precio total actual de todos los items (asumiendo que todos cuestan $42).
  int get totalPrice => _items.length * 42;

  /// Añadir [item] al carro. Esta es la única manera de modificar el carrito desde fuera.
  void add(String item) {
    _items.add(item);
    // Esta llamada dice a los widgets que están escuchando este modelo que se reconstruyan.
    notifyListeners();
  }
}
