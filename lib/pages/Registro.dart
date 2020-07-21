import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'AppBar.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}
class _RegisterPageState extends State<RegisterPage> {


  GlobalKey<FormState> keyForm = new GlobalKey();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _email;
  String _password;
  bool _isregistering =false;
  bool boxValue=false;

  _resgister() async{
    if(_isregistering) return;

    setState(() {
      _isregistering = true;
    });
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text('Registrando Usuario'),
      duration: Duration(seconds: 5),
    ));

    final form=keyForm.currentState;
    if(!form.validate()){
      _scaffoldKey.currentState.hideCurrentSnackBar();
      setState(() {
        _isregistering=false;
      });
      return;
    }
    form.save();
    save();
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
      _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('Usuario Registrado'),
        duration: Duration(seconds: 5),
      ));
      Navigator.of(context).pushReplacementNamed('/Principal');
    }catch(e){
      _scaffoldKey.currentState.hideCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(e.message +'ERROR al registrar Usuario: Intentelo mas tarde!'),
        duration: Duration(seconds: 5),
        action: SnackBarAction(
          label: 'OK',
          onPressed: (){
            _scaffoldKey.currentState.hideCurrentSnackBar();},
        ),
      ));
    }finally{
      setState(() {
        _isregistering=false;
      });
    }
  }

  String url="http://informacion.somee.com/api/Clientes";
  Future<String> enviardatos(String nombre, String apellido, String cedula,  String telefono, String email, String clave) async{
    Map data = {
      "NombreCliente": "${nombre}",
      "ApellidoCliente":"${apellido}",
      "CedulaCliente":"${cedula}",
      "EmailCliente":"${email}",
      "TelefonoCliente":"${telefono}",
      "ClaveCliente":"${clave}"
    };
    String body = jsonEncode(data);
    var respuesta= await http.post(url, headers: <String, String>{"Content-Type": "application/json"}, body: body,);
    if(respuesta.statusCode==201){
      return respuesta.body;
    }
    return "A ocurrido un error en el registro, intentelo nuevamente";

  }
 /* String urls="http://informacion.somee.com/api/Destinos";
  Future<String> creaedestino(String nombre) async{
    var respuest= await http.post(urls, headers: <String, String>{"Content-Type": "application/json",},
      body: jsonEncode({"NombreDestino": nombre}),);
    print(respuest.body);
    print("Cliente en registro");
    return respuest.body;

  }*/
  TextEditingController nombreCtrl = new TextEditingController();
  TextEditingController apellidoCtrl = new TextEditingController();
  TextEditingController cedulaCtrl = new TextEditingController();
  TextEditingController emailCtrl = new TextEditingController();
  TextEditingController telefonoCtrl = new TextEditingController();
  TextEditingController passwordCtrl = new TextEditingController();
  TextEditingController repeatPassCtrl = new TextEditingController();
  final heards = Heard('images/registro.jpg','Registro', 'Es importante su registro');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        body: new CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                title: myAppBar(),
                backgroundColor: Colors.black,
                expandedHeight: 150.0,
                floating: true,
                pinned: true,
                snap: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: MyFlexiableAppBar(heard: heards,),
                ),
              ),
      SliverList(
        delegate: SliverChildListDelegate(<Widget>[
          Container(
            //color: Colors.red,
            margin: new EdgeInsets.all(20.0),
            child: new Form(
              key: keyForm,
              child: formUI(),
            ),
          ),
        ]
        ),
      ),
    ]
    )
    );
  }

  Widget formUI() {

    return Column(
      children: <Widget>[
      Container(
      height: 60,
        child: TextFormField(
          controller: nombreCtrl,
          decoration: new InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(
              Icons.person,
              color: Colors.blue[900],
              size: 15,
            ),
            labelText: 'Nombre:',
          ),
          maxLength: 30,
          validator: validateName,
          style: new TextStyle(
              fontSize: 12.0,
              height: 1.0,
              color: Colors.black
          ),
        ),
      ),
        Container(
          height: 60,
          child: TextFormField(
            controller: apellidoCtrl,
            decoration: new InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person_outline),
              labelText: 'Apellido: ',
            ),
            maxLength: 30,
            validator: validateApellido,
            style: new TextStyle(
                fontSize: 12.0,
                height: 1.0,
                color: Colors.black
            ),
          ),
        ),

        Container(
          height: 60,
          child: TextFormField(
            style: TextStyle(fontSize: 11),
            controller: cedulaCtrl,
            decoration: new InputDecoration(

              errorStyle: TextStyle(fontSize: 10),
              border: OutlineInputBorder(),
              prefixIcon: Icon(
                Icons.fingerprint,
                color: Colors.blue[900],
                size: 15,
              ),
              labelText: 'Cédula: ',

            ),
            maxLength: 10,
            validator: validateCedula,
            keyboardType: TextInputType.number,

          ),
        ),
    Container(
    height: 60,
    child:TextFormField(
      controller: telefonoCtrl,
      decoration: new InputDecoration(
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.phone),
        labelText: 'Teléfono',
      ),
      keyboardType: TextInputType.phone,
      maxLength: 10,
      validator: validateMobile,
      style: new TextStyle(
          fontSize: 12.0,
          height: 1.0,
          color: Colors.black
      ),
    ),
    ),
        Container(
          height: 60,
          child: TextFormField(
            controller: emailCtrl,
            decoration: new InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email),
              labelText: 'Email',
            ),
            keyboardType: TextInputType.emailAddress,
            maxLength: 32,
            validator: validateEmail,
            style: new TextStyle(
                fontSize: 12.0,
                height: 1.0,
                color: Colors.black
            ),
            onSaved: (validateEmail){
              setState(() {
                _email=validateEmail;
              });
            },
          ),
        ),
        Container(
          height: 60,
          child: TextFormField(
            //scrollPadding: EdgeInsets.all(18.0),
            controller: passwordCtrl,
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.vpn_key),
              labelText: 'Contraseña',
            ),
            maxLength: 16,
            style: new TextStyle(
                fontSize: 12.0,
                height: 1.0,
                color: Colors.black
            ),
          ),
        ),
        Container(
          height: 40,
          child: TextFormField(
            controller: repeatPassCtrl,
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.vpn_key),
              labelText: 'Repetir la Contraseña',
            ),
            //maxLength: 16,
            validator: validatePassword,
            style: new TextStyle(
                fontSize: 12.0,
                height: 1.0,
                color: Colors.black
            ),
            onSaved: (validatePassword){
              setState(() {
                _password=validatePassword;
              });
            },
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(5, 20, 5, 5),
          child: Row(
            children: <Widget>[
              Checkbox(
                value: boxValue,
                onChanged: (bool value) {
                  setState(() {
                    boxValue = value;
                  });
                },
              ),
              Text(
                'Acepto terminos y condiciones',
                style: new TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
        GestureDetector(
            onTap: () {
              //save();
              _resgister();
              //Navigator.pushNamed(context, '/Principal');
             // Navigator.of(context).pop();
            },
            child: Container(
              margin: new EdgeInsets.only(left: 1.0, right: 1.0, bottom: 2.0, top: 30.0),
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                gradient: LinearGradient(colors: [
                  Color(0xFF203573),
                  Color(0xFF000000),
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              ),
              child: Text("Registrarse",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
              padding: EdgeInsets.only(top: 10, bottom: 10),
            ),
        )
      ],
    );
  }



  String validatePassword(String value) {
    print("valorrr $value passsword ${passwordCtrl.text}");
    if (value != passwordCtrl.text) {
      return "Las contraseñas no coinciden";
    }
    return null;
  }

  String validateName(String value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "El nombre es necesario";
    } else if (!regExp.hasMatch(value)) {
      return "El nombre debe de ser a-z y A-Z";
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
    String pattern = r'(^[0-9])';
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
      return "El telefono es necesariod";
    } else if (value.length != 10) {
      return "El numero debe tener 10 digitos";
    }
    return null;
  }

  String validateEmail(String value) {
    _scaffoldKey.currentState.hideCurrentSnackBar();

    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(

      content: Text('El correo es necesario'),
        duration: Duration(seconds: 5),
        action: SnackBarAction(
          label: 'OK',
          onPressed: (){
            _scaffoldKey.currentState.hideCurrentSnackBar();},
        ),
      ));
      return "El correo es necesario";

    } else if (!regExp.hasMatch(value)) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text('Correo invalido'),
    duration: Duration(seconds: 5),
    action: SnackBarAction(
    label: 'OK',
    onPressed: (){
    _scaffoldKey.currentState.hideCurrentSnackBar();},
    ),
    ));
      return "Correo invalido";
    } else {
      return null;
    }
  }

  save() {
    if (keyForm.currentState.validate()) {
      print("Nombre ${nombreCtrl.text}");
      print("Apellido ${apellidoCtrl.text}");
      print("Cedula ${cedulaCtrl.text}");
      print("Telefono ${telefonoCtrl.text}");
      //print("Correo ${emailCtrl.text}");

      if (enviardatos(nombreCtrl.text, apellidoCtrl.text, cedulaCtrl.text, telefonoCtrl.text, emailCtrl.text, passwordCtrl.text)!=null)
        {
          print("Registro Exitoso");
          //keyForm.currentState.reset();
        }else{
       print("vaciar form ");
      }
    }
  }
}
