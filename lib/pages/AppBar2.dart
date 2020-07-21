import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

class Heard2 {
  final String fondo;
  final String descripcion1;
  final String numero;
  final double paso;

  Heard2(this.fondo, this.descripcion1, this.numero, this.paso);
}

class myAppBar2 extends StatelessWidget {
  final Heard2 heard2;
  const myAppBar2({this.heard2});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'TransApp',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppinn',
                        fontSize: 20.0),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    Icons.supervised_user_circle,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    ));
  }
}

class MyFlexiableAppBar2 extends StatelessWidget {
  final Heard2 heard2;
  final double appBarHeight = 66.0;

  const MyFlexiableAppBar2({this.heard2});

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    DateTime now = DateTime.now();
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[

        Image.asset(
          heard2.fondo,
          fit: BoxFit.cover,
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.transparent, Colors.black54],
                stops: [0.1, 0.9],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                tileMode: TileMode.repeated),
          ),
        ),

        Positioned(
          left: 16.0,
          right: 16.0,
          bottom: 16.0,
          child: Column(
            children: <Widget>[
              Text(
                '${heard2.numero}',
                style: TextStyle(
                  fontSize: 100.0,
                  color: Colors.white.withOpacity(0.5),
                  fontWeight: FontWeight.w900
                ),
              ),
              Text(
                '${heard2.descripcion1}',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ],
          )
        ),
        Positioned(
          left: 2.0,
          right: 2.0,
          bottom: 0.0,
          child: Container(
            child: LinearProgressIndicator(
              value: heard2.paso,
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
            )),)

      ],
    );
  }
}
