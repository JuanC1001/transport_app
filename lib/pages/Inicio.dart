import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transport_app/pages/Principal.dart';

import 'Provider.dart';

class Inicio extends StatefulWidget  {
  static Route<dynamic> route() {
    return MaterialPageRoute(builder: (context) => Inicio(),
    );
  }
  @override
  _LoginScreenState createState() => _LoginScreenState();
}
class _LoginScreenState extends State<Inicio> {

  GlobalKey<FormState> keyForm = new GlobalKey();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String _email;
  String _password;
  bool _isLoggIn =false;

  _login() async{
    if(_isLoggIn) return;
    setState(() {
      _isLoggIn = true;
    });
    final form=keyForm.currentState;
    if(!form.validate()){
      _scaffoldKey.currentState.hideCurrentSnackBar();
      setState(() {
        _isLoggIn=false;
      });
      return;
    }
    form.save();
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      //return user.uid;
      print("user");
      print(user.uid);
      print(user.email);
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Ingresando'),
        duration: Duration(seconds: 5),
      ));
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed('/Principal');
    }catch(e){
      _scaffoldKey.currentState.hideCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(e.message),
        duration: Duration(seconds: 5),
        action: SnackBarAction(
          label: 'OK',
          onPressed: (){
            _scaffoldKey.currentState.hideCurrentSnackBar();},
        ),
      ));
    }finally{
      setState(() {
        _isLoggIn=false;
      });
    }
  }

  TextEditingController emailCtrl = new TextEditingController();
  TextEditingController passwordCtrl = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    var myProvider = Provider.of<MyProvider>(context);
    //print(_email);
    return new Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      body: Container(
        child: ScrollConfiguration(
        behavior: ScrollBehavior(),
          child: Column(
            children: <Widget>[
              Container(
                margin: new EdgeInsets.only(left: 20.0, right: 20.0, bottom: 2.0, top: 50.0),
                child: Image.asset('images/logo.jpg', width: 200, height: 200),
              ),
              Container(
                child: new Text(
                  "Rápido, fácil y sin filas",
                  style: const TextStyle(
                      fontSize: 20.0,
                      color: Color(0xFF203573),
                      fontWeight: FontWeight.w200),
                ),

              ),
              Container(
                margin: new EdgeInsets.only(left: 20.0, right: 20.0, bottom: 2.0, top: 20.0),
                child: new Form(
                  key: keyForm,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          controller: emailCtrl,
                          style: TextStyle(fontSize: 15),
                          validator: validateEmail,
                          decoration: new InputDecoration(
                            isDense: true,
                            //contentPadding: EdgeInsets.all(5),
                            //errorStyle: TextStyle(fontSize: 10),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.email, color: Color(0xFF203573)),
                            labelText: 'Correo electrónico',
                          ),
                          onSaved: (validateEmail){
                            setState(() {
                              _email=validateEmail;
                            });
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          controller: passwordCtrl,
                          obscureText: true,
                          style: TextStyle(fontSize: 15),
                          validator: validatePassword,
                          decoration: new InputDecoration(
                            isDense: true,
                            //contentPadding: EdgeInsets.all(5),
                            //errorStyle: TextStyle(fontSize: 10),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.vpn_key, color: Color(0xFF203573)),
                            labelText: 'Contraseña',
                          ),
                          onSaved: (validatePassword){
                            setState(() {
                              _password=validatePassword;
                            });
                          },
                        ),
                      ),

                      Container(
                        margin: new EdgeInsets.only(left: 5.0, right: 5.0, bottom: 20.0, top: 20.0),
                        child: GestureDetector(
                          onTap: () {
                                 _login();
                                 myProvider.miemail=_email;
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(10, 13, 10, 13),
                            alignment: Alignment.center,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.0)),
                              color: Colors.green,
                            ),
                            child: Text("Iniciar Sesión",
                                style: TextStyle(
                                    color: Colors.white,
                                    //fontSize: 14,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ),
                      InkWell(
                          child: Text("¿Olvidaste tu contraseña?", style: TextStyle(color: Colors.blue[600], fontWeight: FontWeight.w600),),
                          onTap: () => Navigator.pushNamed(context, '/Paso1')
                      ),

                      Divider(height: 20,),
                      Text('o'),
                      Container(
                        margin: new EdgeInsets.only(left: 100.0, right: 100.0, bottom: 5.0, top: 5.0),
                        child: GestureDetector(
                          onTap: () {
                            //Navigator.pushNamed(context, '/Prueba');
                            Navigator.pushNamed(context, '/Registro');
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2.0)),
                              color: Colors.green[700],

                            ),
                            child: Text("Registrate",
                                style: TextStyle(
                                    color: Colors.white,
                                    //fontSize: 14,
                                    fontWeight: FontWeight.w600)),
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                          ),
                        ),
                      ),
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

/*  Widget loginForm() {
    return Column(
      children: <Widget>[
        Container(
          margin: new EdgeInsets.only(left: 20.0, right: 20.0, bottom: 2.0, top: 100.0),
          child: Image.asset('images/logo.jpg', width: 150, height: 150),
        ),
        Container(
          child: new Text(
            "Rápido, fácil y sin filas",
            style: const TextStyle(
                fontSize: 20.0,
                color: Color(0xFF203573),
                fontWeight: FontWeight.w200),
          ),

        ),
        Container(
          margin: new EdgeInsets.only(left: 20.0, right: 20.0, bottom: 2.0, top: 20.0),
          child: new Form(
            key: keyForm,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(5),
                  child: TextFormField(
                    //controller: nombreCtrl,
                    style: TextStyle(fontSize: 15),
                    //validator: validateName,
                    decoration: new InputDecoration(
                      isDense: true,
                      //contentPadding: EdgeInsets.all(5),
                      //errorStyle: TextStyle(fontSize: 10),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email, color: Color(0xFF203573)),
                      labelText: 'Correo electrónico',
                    ),
                    //maxLength: 50,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: TextFormField(
                    //controller: passwordCtrl,
                    obscureText: true,
                    style: TextStyle(fontSize: 15),
                    //validator: validatePassword,
                    decoration: new InputDecoration(
                      isDense: true,
                      //contentPadding: EdgeInsets.all(5),
                      //errorStyle: TextStyle(fontSize: 10),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.vpn_key, color: Color(0xFF203573)),
                      labelText: 'Contraseña',
                    ),
                    //maxLength: 50,
                  ),
                ),

                Container(
                  margin: new EdgeInsets.only(left: 5.0, right: 5.0, bottom: 20.0, top: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      if (keyForm.currentState.validate()) {
                        _login();
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10, 13, 10, 13),
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0)),
                        color: Color(0xFF002151),
                      ),
                      child: Text("Iniciar Sesión",
                          style: TextStyle(
                              color: Colors.white,
                              //fontSize: 14,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                ),
                InkWell(
                  child: Text("¿Olvidaste tu contraseña?", style: TextStyle(color: Colors.blue[600], fontWeight: FontWeight.w600),),
                    onTap: () => Navigator.pushNamed(context, '/Paso1')
                ),

                Divider(height: 20,),
                Text('o'),
                Container(
                  margin: new EdgeInsets.only(left: 100.0, right: 100.0, bottom: 5.0, top: 5.0),
                  child: GestureDetector(
                    onTap: () {
                      //Navigator.pushNamed(context, '/Prueba');
                      Navigator.pushNamed(context, '/Registro');
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2.0)),
                        color: Colors.green[700],

                      ),
                      child: Text("Registrarse",
                          style: TextStyle(
                              color: Colors.white,
                              //fontSize: 14,
                              fontWeight: FontWeight.w600)),
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

      ],
    );
  }*/

  String validatePassword(String value) {
    //print("valorrr $value passsword ${passwordCtrl.text}");
    if (value.length == 0) {
      return "La contaseña es necesaria";
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





class ImageLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('images/logo.jpg');
    Image image = Image(image: assetImage);
    return Container(
      child: image,
    );
  }
}

class BackWheater extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        new GradientBack(),
        new Positioned(
            bottom: 0.0,
            child: new Container(
              width: MediaQuery.of(context).size.width,
              height: 10.0,
              color: Color(0xFF203573),
            ))
      ],
    );
  }
}

class GradientBack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [Color(0xFFf7f7f7), Color(0xFFF7F7F7)],
              begin: const FractionalOffset(1.0, 0.1),
              end: const FractionalOffset(1.0, 0.9))),
    );
  }
}
