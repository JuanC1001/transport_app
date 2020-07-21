import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'AppBar2.dart';

class myReservas extends StatelessWidget {
  final heard2 = Heard2('images/fechas.jpg', 'Reservaciones Pendientes', 'R', 0.0);
  @override
  Widget build(BuildContext context) {
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
                Container(
                  padding: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 20),
                  child: Column(
                    children: <Widget>[
                      Text('Pago por PAYPHONE'),
                      Text('Pago por PAYPAL'),
                    ],
                  ),
                ),

              ]))
        ],
      ),
    );
  }
}
