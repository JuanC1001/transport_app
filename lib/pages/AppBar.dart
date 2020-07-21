import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

class Heard {
  final String fondo;
  final String descripcion1;
  final String descripcion2;

  Heard(this.fondo, this.descripcion1, this.descripcion2);
}

class myAppBar extends StatelessWidget {
  final Heard heard;

  const myAppBar({this.heard});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'TransApp',
                style: TextStyle(
                    color: Colors.white, fontFamily: 'Poppinn', fontSize: 20.0),
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
    );
  }
}

class MyFlexiableAppBar extends StatelessWidget {
  final Heard heard;
  final double appBarHeight = 66.0;

  const MyFlexiableAppBar({this.heard});

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    DateTime now = DateTime.now();
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image.asset(
          heard.fondo,
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
          child: Text(
            '${heard.descripcion1}',
            style: TextStyle(
              fontSize: 28.0,
              color: Colors.white.withOpacity(0.5),
            ),
          ),
        ),
      ],
    );
  }
}

