import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
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

class Paso2 extends StatefulWidget {
  @override
  Paso02 createState() => Paso02();
}

class Paso02 extends State<Paso2> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final heard2 = Heard2('images/asientos3.jpg', 'Elige tu asiento favorito', '2', 0.4);
  var selected = [];
  int count = 0;
  int disponible = 48;
  double total=0;
  double tarifa=0;

  @override
  Widget build(BuildContext context) {
    var myProvider = Provider.of<MyProvider>(context);
    tarifa=myProvider.mitarifa;
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
                  padding: EdgeInsets.all(10.0),
                  //color: Colors.blue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Icon(Icons.weekend, color: Colors.green),
                      Container(
                        child: Text('Disponible:' + '$disponible'),
                      ),
                      Icon(Icons.weekend, color: Colors.red),
                      Container(
                        child: Text('Ocupado:'+'$count'),
                      ),
                      Icon(Icons.weekend, color: Colors.amber),
                      Container(
                        child: Text('Seleccionado:' + '$count'),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 30.0,
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //mainAxisSize: MainAxisSize.min,

                  children: <Widget>[
                   FilterChip(

                      materialTapTargetSize: MaterialTapTargetSize.padded,

                      label: Text(' 1 '),
                      onSelected: (bool value) {
                        if (selected.contains(1)) {
                          selected.remove(1);
                          count = count - 1;
                          total=count*tarifa;
                          disponible = disponible + 1;
                        } else {
                          selected.add(1);
                          count = count + 1;
                          total=count*tarifa;
                          disponible = disponible - 1;

                        }
                        setState(() {});
                      },
                      selected: selected.contains(1),
                      selectedColor: Colors.red,
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.green,
                      showCheckmark: false,
                    ),

                    FilterChip(
                      label: Text(' 2 '),
                      onSelected: (bool value) {
                        if (selected.contains(2)) {
                          selected.remove(2);
                          count = count - 1;
                          total=count*tarifa;

                          disponible = disponible + 1;

                        } else {
                          selected.add(2);
                          count = count + 1;
                          total=count*tarifa;
                          disponible = disponible - 1;

                        }
                        setState(() {});
                      },
                      selected: selected.contains(2),
                      selectedColor: Colors.red,
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.green,
                      showCheckmark: false,
                    ),
                    Text('     '),
                    FilterChip(
                      label: Text(' 3 '),
                      onSelected: (bool value) {
                        if (selected.contains(3)) {
                          selected.remove(3);
                          count = count - 1;
                          total=count*tarifa;
                          disponible = disponible + 1;

                        } else {
                          selected.add(3);
                          count = count + 1;
                          total=count*tarifa;
                          disponible = disponible - 1;
                        }
                        setState(() {});
                      },
                      selected: selected.contains(3),
                      selectedColor: Colors.red,
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.green,
                      showCheckmark: false,
                    ),
                    FilterChip(
                      label: Text(' 4 '),
                      onSelected: (bool value) {
                        if (selected.contains(4)) {
                          selected.remove(4);
                          count = count - 1;
                          total=count*tarifa;
                          disponible = disponible + 1;
                        } else {
                          selected.add(4);
                          count = count + 1;
                          total=count*tarifa;
                          disponible = disponible - 1;

                        }
                        setState(() {});
                      },
                      selected: selected.contains(4),
                      selectedColor: Colors.red,
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.green,
                      showCheckmark: false,
                    ),
                  ],
                ),
                  ),
                Container(
                  height: 30.0,
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FilterChip(
                      label: Text(' 5 '),
                      onSelected: (bool value) {
                        if (selected.contains(5)) {
                          selected.remove(5);
                          count = count - 1;
                          total=count*tarifa;
                          disponible = disponible + 1;
                        } else {
                          selected.add(5);
                          count = count + 1;
                          total=count*tarifa;
                          disponible = disponible - 1;
                        }
                        setState(() {});
                      },
                      selected: selected.contains(5),
                      selectedColor: Colors.red,
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.green,
                      showCheckmark: false,
                    ),

                    FilterChip(
                      label: Text(' 6 '),
                      onSelected: (bool value) {
                        if (selected.contains(6)) {
                          selected.remove(6);
                          count = count - 1;
                          total=count*tarifa;
                          disponible = disponible + 1;
                        } else {
                          selected.add(6);
                          count = count + 1;
                          total=count*tarifa;
                          disponible = disponible - 1;
                        }
                        setState(() {});
                      },
                      selected: selected.contains(6),
                      selectedColor: Colors.red,
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.green,
                      showCheckmark: false,
                    ),
                    Text('     '),
                    FilterChip(
                      label: Text(' 7 '),
                      onSelected: (bool value) {
                        if (selected.contains(7)) {
                          selected.remove(7);
                          count = count - 1;
                          total=count*tarifa;
                          disponible = disponible + 1;
                        } else {
                          selected.add(7);
                          count = count + 1;
                          total=count*tarifa;
                          disponible = disponible - 1;
                        }
                        setState(() {});
                      },
                      selected: selected.contains(7),
                      selectedColor: Colors.red,
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.green,
                      showCheckmark: false,
                    ),
                    FilterChip(
                      label: Text(' 8 '),
                      onSelected: (bool value) {
                        if (selected.contains(8)) {
                          selected.remove(8);
                          count = count - 1;
                          total=count*tarifa;
                          disponible = disponible + 1;
                        } else {
                          selected.add(8);
                          count = count + 1;
                          total=count*tarifa;
                          disponible = disponible - 1;
                        }
                        setState(() {});
                      },
                      selected: selected.contains(8),
                      selectedColor: Colors.red,
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.green,
                      showCheckmark: false,
                    ),
                  ],
                ),
                  ),
                Container(
                  height: 30.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FilterChip(
                      label: Text(' 9 '),
                      onSelected: (bool value) {
                        if (selected.contains(9)) {
                          selected.remove(9);
                          count = count - 1;
                          total=count*tarifa;
                          disponible = disponible + 1;
                        } else {
                          selected.add(9);
                          count = count + 1;
                          total=count*tarifa;
                          disponible = disponible - 1;
                        }
                        setState(() {});
                      },
                      selected: selected.contains(9),
                      selectedColor: Colors.red,
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.green,
                      showCheckmark: false,
                    ),
                    FilterChip(
                      label: Text('10'),
                      onSelected: (bool value) {
                        if (selected.contains(10)) {
                          selected.remove(10);
                          count = count - 1;
                          total=count*tarifa;
                          disponible = disponible + 1;
                        } else {
                          selected.add(10);
                          count = count + 1;
                          total=count*tarifa;
                          disponible = disponible - 1;
                        }
                        setState(() {});
                      },
                      selected: selected.contains(10),
                      selectedColor: Colors.red,
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.green,
                      showCheckmark: false,
                    ),
                    Text('     '),
                    FilterChip(
                      label: Text('11'),
                      onSelected: (bool value) {
                        if (selected.contains(11)) {
                          selected.remove(11);
                          count = count - 1;
                          total=count*tarifa;
                          disponible = disponible + 1;
                        } else {
                          selected.add(11);
                          count = count + 1;
                          total=count*tarifa;
                          disponible = disponible - 1;
                        }
                        setState(() {});
                      },
                      selected: selected.contains(11),
                      selectedColor: Colors.red,
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.green,
                      showCheckmark: false,
                    ),
                    FilterChip(
                      label: Text('12'),
                      onSelected: (bool value) {
                        if (selected.contains(12)) {
                          selected.remove(12);
                          count = count - 1;
                          total=count*tarifa;
                          disponible = disponible + 1;
                        } else {
                          selected.add(12);
                          count = count + 1;
                          total=count*tarifa;
                          disponible = disponible - 1;
                        }
                        setState(() {});
                      },
                      selected: selected.contains(12),
                      selectedColor: Colors.red,
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.green,
                      showCheckmark: false,
                    ),
                  ],
                ),

                  ),
                Container(
                  height: 30.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //mainAxisSize: MainAxisSize.min,

                    children: <Widget>[
                      FilterChip(

                        materialTapTargetSize: MaterialTapTargetSize.padded,

                        label: Text('13'),
                        onSelected: (bool value) {
                          if (selected.contains(13)) {
                            selected.remove(13);
                            count = count - 1;
                            total=count*tarifa;
                            disponible = disponible + 1;
                          } else {
                            selected.add(13);
                            count = count + 1;
                            total=count*tarifa;
                            disponible = disponible - 1;
                          }
                          setState(() {});
                        },
                        selected: selected.contains(13),
                        selectedColor: Colors.red,
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.green,
                        showCheckmark: false,
                      ),

                      FilterChip(
                        label: Text('14'),
                        onSelected: (bool value) {
                          if (selected.contains(14)) {
                            selected.remove(14);
                            count = count - 1;
                            total=count*tarifa;
                            disponible = disponible + 1;
                          } else {
                            selected.add(14);
                            count = count + 1;
                            total=count*tarifa;
                            disponible = disponible - 1;
                          }
                          setState(() {});
                        },
                        selected: selected.contains(14),
                        selectedColor: Colors.red,
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.green,
                        showCheckmark: false,
                      ),
                      Text('     '),
                      FilterChip(
                        label: Text('15'),
                        onSelected: (bool value) {
                          if (selected.contains(15)) {
                            selected.remove(15);
                            count = count - 1;
                            total=count*tarifa;
                            disponible = disponible + 1;
                          } else {
                            selected.add(15);
                            count = count + 1;
                            total=count*tarifa;
                            disponible = disponible - 1;
                          }
                          setState(() {});
                        },
                        selected: selected.contains(15),
                        selectedColor: Colors.red,
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.green,
                        showCheckmark: false,
                      ),
                      FilterChip(
                        label: Text('16'),
                        onSelected: (bool value) {
                          if (selected.contains(16)) {
                            selected.remove(16);
                            count = count - 1;
                            total=count*tarifa;
                            disponible = disponible + 1;
                          } else {
                            selected.add(16);
                            count = count + 1;
                            total=count*tarifa;
                            disponible = disponible - 1;
                          }
                          setState(() {});
                        },
                        selected: selected.contains(16),
                        selectedColor: Colors.red,
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.green,
                        showCheckmark: false,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 30.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FilterChip(
                        label: Text('17'),
                        onSelected: (bool value) {
                          if (selected.contains(17)) {
                            selected.remove(17);
                            count = count - 1;
                            total=count*tarifa;
                            disponible = disponible + 1;
                          } else {
                            selected.add(17);
                            count = count + 1;
                            total=count*tarifa;
                            disponible = disponible - 1;
                          }
                          setState(() {});
                        },
                        selected: selected.contains(17),
                        selectedColor: Colors.red,
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.green,
                        showCheckmark: false,
                      ),

                      FilterChip(
                        label: Text('18'),
                        onSelected: (bool value) {
                          if (selected.contains(18)) {
                            selected.remove(18);
                            count = count - 1;
                            total=count*tarifa;
                            disponible = disponible + 1;
                          } else {
                            selected.add(18);
                            count = count + 1;
                            total=count*tarifa;
                            disponible = disponible - 1;
                          }
                          setState(() {});
                        },
                        selected: selected.contains(18),
                        selectedColor: Colors.red,
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.green,
                        showCheckmark: false,
                      ),
                      Text('     '),
                      FilterChip(
                        label: Text('19'),
                        onSelected: (bool value) {
                          if (selected.contains(19)) {
                            selected.remove(19);
                            count = count - 1;
                            total=count*tarifa;
                            disponible = disponible + 1;
                          } else {
                            selected.add(19);
                            count = count + 1;
                            total=count*tarifa;
                            disponible = disponible - 1;
                          }
                          setState(() {});
                        },
                        selected: selected.contains(19),
                        selectedColor: Colors.red,
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.green,
                        showCheckmark: false,
                      ),
                      FilterChip(
                        label: Text('20'),
                        onSelected: (bool value) {
                          if (selected.contains(20)) {
                            selected.remove(20);
                            count = count - 1;
                            total=count*tarifa;
                            disponible = disponible + 1;
                          } else {
                            selected.add(20);
                            count = count + 1;
                            total=count*tarifa;
                            disponible = disponible - 1;
                          }
                          setState(() {});
                        },
                        selected: selected.contains(20),
                        selectedColor: Colors.red,
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.green,
                        showCheckmark: false,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 30.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FilterChip(
                        label: Text('21'),
                        onSelected: (bool value) {
                          if (selected.contains(21)) {
                            selected.remove(21);
                            count = count - 1;
                            total=count*tarifa;
                            disponible = disponible + 1;
                          } else {
                            selected.add(21);
                            count = count + 1;
                            total=count*tarifa;
                            disponible = disponible - 1;
                          }
                          setState(() {});
                        },
                        selected: selected.contains(21),
                        selectedColor: Colors.red,
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.green,
                        showCheckmark: false,
                      ),
                      FilterChip(
                        label: Text('22'),
                        onSelected: (bool value) {
                          if (selected.contains(22)) {
                            selected.remove(22);
                            count = count - 1;
                            total=count*tarifa;
                            disponible = disponible + 1;
                          } else {
                            selected.add(22);
                            count = count + 1;
                            total=count*tarifa;
                            disponible = disponible - 1;
                          }
                          setState(() {});
                        },
                        selected: selected.contains(22),
                        selectedColor: Colors.red,
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.green,
                        showCheckmark: false,
                      ),
                      Text('     '),
                      FilterChip(
                        label: Text('23'),
                        onSelected: (bool value) {
                          if (selected.contains(23)) {
                            selected.remove(23);
                            count = count - 1;
                            total=count*tarifa;
                            disponible = disponible + 1;
                          } else {
                            selected.add(23);
                            count = count + 1;
                            total=count*tarifa;
                            disponible = disponible - 1;
                          }
                          setState(() {});
                        },
                        selected: selected.contains(23),
                        selectedColor: Colors.red,
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.green,
                        showCheckmark: false,
                      ),
                      FilterChip(
                        label: Text('24'),
                        onSelected: (bool value) {
                          if (selected.contains(24)) {
                            selected.remove(24);
                            count = count - 1;
                            total=count*tarifa;
                            disponible = disponible + 1;
                          } else {
                            selected.add(24);
                            count = count + 1;
                            total=count*tarifa;
                            disponible = disponible - 1;
                          }
                          setState(() {});
                        },
                        selected: selected.contains(24),
                        selectedColor: Colors.red,
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.green,
                        showCheckmark: false,
                      ),
                    ],
                  ),

                ),
                Container(
                  height: 30.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FilterChip(
                        label: Text('25'),
                        onSelected: (bool value) {
                          if (selected.contains(25)) {
                            selected.remove(25);
                            count = count - 1;
                            total=count*tarifa;
                            disponible = disponible + 1;
                          } else {
                            selected.add(25);
                            count = count + 1;
                            total=count*tarifa;
                            disponible = disponible - 1;
                          }
                          setState(() {});
                        },
                        selected: selected.contains(25),
                        selectedColor: Colors.red,
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.green,
                        showCheckmark: false,
                      ),
                      FilterChip(
                        label: Text('26'),
                        onSelected: (bool value) {
                          if (selected.contains(26)) {
                            selected.remove(26);
                            count = count - 1;
                            total=count*tarifa;
                            disponible = disponible + 1;
                          } else {
                            selected.add(26);
                            count = count + 1;
                            total=count*tarifa;
                            disponible = disponible - 1;
                          }
                          setState(() {});
                        },
                        selected: selected.contains(26),
                        selectedColor: Colors.red,
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.green,
                        showCheckmark: false,
                      ),
                      Text('     '),
                      FilterChip(
                        label: Text('27'),
                        onSelected: (bool value) {
                          if (selected.contains(27)) {
                            selected.remove(27);
                            count = count - 1;
                            total=count*tarifa;
                            disponible = disponible + 1;
                          } else {
                            selected.add(27);
                            count = count + 1;
                            total=count*tarifa;
                            disponible = disponible - 1;
                          }
                          setState(() {});
                        },
                        selected: selected.contains(27),
                        selectedColor: Colors.red,
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.green,
                        showCheckmark: false,
                      ),
                      FilterChip(
                        label: Text('28'),
                        onSelected: (bool value) {
                          if (selected.contains(28)) {
                            selected.remove(28);
                            count = count - 1;
                            total=count*tarifa;
                            disponible = disponible + 1;
                          } else {
                            selected.add(28);
                            count = count + 1;
                            total=count*tarifa;
                            disponible = disponible - 1;
                          }
                          setState(() {});
                        },
                        selected: selected.contains(28),
                        selectedColor: Colors.red,
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.green,
                        showCheckmark: false,
                      ),
                    ],
                  ),

                ),
                Container(
                  height: 30.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //mainAxisSize: MainAxisSize.min,

                    children: <Widget>[
                      FilterChip(
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        label: Text('29'),
                        onSelected: (bool value) {
                          if (selected.contains(29)) {
                            selected.remove(29);
                            count = count - 1;
                            total=count*tarifa;
                            disponible = disponible + 1;
                          } else {
                            selected.add(29);
                            count = count + 1;
                            total=count*tarifa;
                            disponible = disponible - 1;
                          }
                          setState(() {});
                        },
                        selected: selected.contains(29),
                        selectedColor: Colors.red,
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.green,
                        showCheckmark: false,
                      ),

                      FilterChip(
                        label: Text('30'),
                        onSelected: (bool value) {
                          if (selected.contains(30)) {
                            selected.remove(30);
                            count = count - 1;
                            total=count*tarifa;
                            disponible = disponible + 1;
                          } else {
                            selected.add(30);
                            count = count + 1;
                            total=count*tarifa;
                            disponible = disponible - 1;
                          }
                          setState(() {});
                        },
                        selected: selected.contains(30),
                        selectedColor: Colors.red,
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.green,
                        showCheckmark: false,
                      ),
                      Text('     '),
                      FilterChip(
                        label: Text('31'),
                        onSelected: (bool value) {
                          if (selected.contains(31)) {
                            selected.remove(31);
                            count = count - 1;
                            total=count*tarifa;
                            disponible = disponible + 1;
                          } else {
                            selected.add(31);
                            count = count + 1;
                            total=count*tarifa;
                            disponible = disponible - 1;
                          }
                          setState(() {});
                        },
                        selected: selected.contains(31),
                        selectedColor: Colors.red,
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.green,
                        showCheckmark: false,
                      ),
                      FilterChip(
                        label: Text('32'),
                        onSelected: (bool value) {
                          if (selected.contains(32)) {
                            selected.remove(32);
                            count = count - 1;
                            total=count*tarifa;
                            disponible = disponible + 1;
                          } else {
                            selected.add(32);
                            count = count + 1;
                            total=count*tarifa;
                            disponible = disponible - 1;
                          }
                          setState(() {});
                        },
                        selected: selected.contains(32),
                        selectedColor: Colors.red,
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.green,
                        showCheckmark: false,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 30.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FilterChip(
                        label: Text('33'),
                        onSelected: (bool value) {
                          if (selected.contains(33)) {
                            selected.remove(33);
                            count = count - 1;
                            total=count*tarifa;
                            disponible = disponible + 1;
                          } else {
                            selected.add(33);
                            count = count + 1;
                            total=count*tarifa;
                            disponible = disponible - 1;
                          }
                          setState(() {});
                        },
                        selected: selected.contains(33),
                        selectedColor: Colors.red,
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.green,
                        showCheckmark: false,
                      ),

                      FilterChip(
                        label: Text('34'),
                        onSelected: (bool value) {
                          if (selected.contains(34)) {
                            selected.remove(34);
                            count = count - 1;
                            total=count*tarifa;
                            disponible = disponible + 1;
                          } else {
                            selected.add(34);
                            count = count + 1;
                            total=count*tarifa;
                            disponible = disponible - 1;
                          }
                          setState(() {});
                        },
                        selected: selected.contains(34),
                        selectedColor: Colors.red,
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.green,
                        showCheckmark: false,
                      ),
                      Text('     '),
                      FilterChip(
                        label: Text('35'),
                        onSelected: (bool value) {
                          if (selected.contains(35)) {
                            selected.remove(35);
                            count = count - 1;
                            total=count*tarifa;
                            disponible = disponible + 1;
                          } else {
                            selected.add(35);
                            count = count + 1;
                            total=count*tarifa;
                            disponible = disponible - 1;
                          }
                          setState(() {});
                        },
                        selected: selected.contains(35),
                        selectedColor: Colors.red,
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.green,
                        showCheckmark: false,
                      ),
                      FilterChip(
                        label: Text('36'),
                        onSelected: (bool value) {
                          if (selected.contains(36)) {
                            selected.remove(36);
                            count = count - 1;
                            total=count*tarifa;
                            disponible = disponible + 1;
                          } else {
                            selected.add(36);
                            count = count + 1;
                            total=count*tarifa;
                            disponible = disponible - 1;
                          }
                          setState(() {});
                        },
                        selected: selected.contains(36),
                        selectedColor: Colors.red,
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.green,
                        showCheckmark: false,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 30.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FilterChip(
                        label: Text('37'),
                        onSelected: (bool value) {
                          if (selected.contains(37)) {
                            selected.remove(37);
                            count = count - 1;
                            total=count*tarifa;
                            disponible = disponible + 1;
                          } else {
                            selected.add(37);
                            count = count + 1;
                            total=count*tarifa;
                            disponible = disponible - 1;
                          }
                          setState(() {});
                        },
                        selected: selected.contains(37),
                        selectedColor: Colors.red,
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.green,
                        showCheckmark: false,
                      ),
                      FilterChip(
                        label: Text('38'),
                        onSelected: (bool value) {
                          if (selected.contains(38)) {
                            selected.remove(38);
                            count = count - 1;
                            total=count*tarifa;
                            disponible = disponible + 1;
                          } else {
                            selected.add(38);
                            count = count + 1;
                            total=count*tarifa;
                            disponible = disponible - 1;
                          }
                          setState(() {});
                        },
                        selected: selected.contains(38),
                        selectedColor: Colors.red,
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.green,
                        showCheckmark: false,
                      ),
                      Text('     '),
                      FilterChip(
                        label: Text('39'),
                        onSelected: (bool value) {
                          if (selected.contains(39)) {
                            selected.remove(39);
                            count = count - 1;
                            total=count*tarifa;
                            disponible = disponible + 1;
                          } else {
                            selected.add(39);
                            count = count + 1;
                            total=count*tarifa;
                            disponible = disponible - 1;
                          }
                          setState(() {});
                        },
                        selected: selected.contains(39),
                        selectedColor: Colors.red,
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.green,
                        showCheckmark: false,
                      ),
                      FilterChip(
                        label: Text('40'),
                        onSelected: (bool value) {
                          if (selected.contains(40)) {
                            selected.remove(40);
                            count = count - 1;
                            total=count*tarifa;
                            disponible = disponible + 1;
                          } else {
                            selected.add(40);
                            count = count + 1;
                            total=count*tarifa;
                            disponible = disponible - 1;
                          }
                          setState(() {});
                        },
                        selected: selected.contains(40),
                        selectedColor: Colors.red,
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.green,
                        showCheckmark: false,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 30.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FilterChip(
                        label: Text('41'),
                        onSelected: (bool value) {
                          if (selected.contains(41)) {
                            selected.remove(41);
                            count = count - 1;
                            total=count*tarifa;
                            disponible = disponible + 1;
                          } else {
                            selected.add(41);
                            count = count + 1;
                            total=count*tarifa;
                            disponible = disponible - 1;
                          }
                          setState(() {});
                        },
                        selected: selected.contains(41),
                        selectedColor: Colors.red,
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.green,
                        showCheckmark: false,
                      ),
                      FilterChip(
                        label: Text('42'),
                        onSelected: (bool value) {
                          if (selected.contains(42)) {
                            selected.remove(42);
                            count = count - 1;
                            total=count*tarifa;
                            disponible = disponible + 1;
                          } else {
                            selected.add(42);
                            count = count + 1;
                            total=count*tarifa;
                            disponible = disponible - 1;
                          }
                          setState(() {});
                        },
                        selected: selected.contains(42),
                        selectedColor: Colors.red,
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.green,
                        showCheckmark: false,
                      ),
                      Text('     '),
                      FilterChip(
                        label: Text('43'),
                        onSelected: (bool value) {
                          if (selected.contains(43)) {
                            selected.remove(43);
                            count = count - 1;
                            total=count*tarifa;
                            disponible = disponible + 1;
                          } else {
                            selected.add(43);
                            count = count + 1;
                            total=count*tarifa;
                            disponible = disponible - 1;
                          }
                          setState(() {});
                        },
                        selected: selected.contains(43),
                        selectedColor: Colors.red,
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.green,
                        showCheckmark: false,
                      ),
                      FilterChip(
                        label: Text('44'),
                        onSelected: (bool value) {
                          if (selected.contains(44)) {
                            selected.remove(44);
                            count = count - 1;
                            total=count*tarifa;
                            disponible = disponible + 1;
                          } else {
                            selected.add(44);
                            count = count + 1;
                            total=count*tarifa;
                            disponible = disponible - 1;
                          }
                          setState(() {});
                        },
                        selected: selected.contains(44),
                        selectedColor: Colors.red,
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.green,
                        showCheckmark: false,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 30.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FilterChip(
                        label: Text('45'),
                        onSelected: (bool value) {
                          if (selected.contains(45)) {
                            selected.remove(45);
                            count = count - 1;
                            total=count*tarifa;
                            disponible = disponible + 1;
                          } else {
                            selected.add(45);
                            count = count + 1;
                            total=count*tarifa;
                            disponible = disponible - 1;
                          }
                          setState(() {});
                        },
                        selected: selected.contains(45),
                        selectedColor: Colors.red,
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.green,
                        showCheckmark: false,
                      ),
                      FilterChip(
                        label: Text('46'),
                        onSelected: (bool value) {
                          if (selected.contains(46)) {
                            selected.remove(46);
                            count = count - 1;
                            total=count*tarifa;
                            disponible = disponible + 1;
                          } else {
                            selected.add(46);
                            count = count + 1;
                            total=count*tarifa;
                            disponible = disponible - 1;
                          }
                          setState(() {});
                        },
                        selected: selected.contains(46),
                        selectedColor: Colors.red,
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.green,
                        showCheckmark: false,
                      ),
                      Text('     '),
                      FilterChip(
                        label: Text('47'),
                        onSelected: (bool value) {
                          if (selected.contains(47)) {
                            selected.remove(47);
                            count = count - 1;
                            total=count*tarifa;
                            disponible = disponible + 1;
                          } else {
                            selected.add(47);
                            count = count + 1;
                            total=count*tarifa;
                            disponible = disponible - 1;
                          }
                          setState(() {});
                        },
                        selected: selected.contains(47),
                        selectedColor: Colors.red,
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.green,
                        showCheckmark: false,
                      ),
                      FilterChip(
                        label: Text('48'),
                        onSelected: (bool value) {
                          if (selected.contains(48)) {
                            selected.remove(48);
                            count = count - 1;
                            total=count*tarifa;
                            disponible = disponible + 1;
                          } else {
                            selected.add(48);
                            count = count + 1;
                            total=count*tarifa;
                            disponible = disponible - 1;
                          }
                          setState(() {});
                        },
                        selected: selected.contains(48),
                        selectedColor: Colors.red,
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.green,
                        showCheckmark: false,
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: Text('$selected',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  subtitle: Text('Número de asiento(s)'),
                  leading: Icon(
                    Icons.weekend,
                    color: Colors.black,
                  ),
                ),
              ]),
          )
        ],
      ),
      persistentFooterButtons: <Widget>[
        Text('Total: '),
        SizedBox(
          width: 110,
          height: 40,
          child: TextField(
          style: TextStyle(fontSize: 14),
          decoration: new InputDecoration(
             border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.attach_money),
              labelText: '$total',
          ),
          enabled: false,
        ),
        ),

        RaisedButton(
          onPressed: () {
            if(count>0) {
              myProvider.micantidadAsientos = count;
              myProvider.miTotal = total;
              myProvider.minumeroAsientos = selected;
              Navigator.pushNamed(context, '/Paso3');
            }else{
              _scaffoldKey.currentState.hideCurrentSnackBar();
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text("Seleccione almenos un ASIENTO"),
                duration: Duration(seconds: 5),
                action: SnackBarAction(
                  label: 'OK', textColor: Colors.white70,
                  onPressed: () {
                    _scaffoldKey.currentState.hideCurrentSnackBar();
                  },
                ),
              ));
            }
          },
          color: Colors.amber,
          padding: const EdgeInsets.only(
              bottom: 10.0, top: 10.0, left: 30.0, right: 30.0),
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
}
