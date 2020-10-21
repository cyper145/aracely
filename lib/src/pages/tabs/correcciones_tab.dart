import 'dart:async';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Correctivotab extends StatefulWidget {
  @override
  _Correctivotab createState() => _Correctivotab();
}

class _Correctivotab extends State<Correctivotab> {
  String carModel;
  String carColor;

  var cars;

  String name;

  String severidad;
  int nroPersonas;
  String nroInseguridad = '0.00';
  String nroSeguridad = '0.00';
  int nroPersonasT = 0;
  List<Map<String, dynamic>> listtem = new List();

  Future<bool> dialogTrigger(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Job Done', style: TextStyle(fontSize: 15.0)),
            content: Text('Added'),
            actions: <Widget>[
              FlatButton(
                child: Text('Alright'),
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          backgroundColor: Colors.purple[700],
          actions: <Widget>[
            IconButton(
              hoverColor: Colors.blue,
              icon: Icon(Icons.add),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {},
            )
          ],
        ),
        body: Center(
          child: _carList(),
        ));
  }

  Widget _carList() {
    if (cars != null) {
      return StreamBuilder(stream: cars, builder: (context, snapshot) {});
    } else {
      return Text('Loading, Please wait..');
    }
  }
}

void _showDialog(context, index) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Alert'),
        content: Text('desea eliminar el registro?'),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.purple,
              ),
              onPressed: () {}),
          new FlatButton(
            child: Text('salir'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

String subtotal(String severidad, int nroPersonas) {
  double subtotal = double.parse(severidad) * nroPersonas;
  return subtotal.toStringAsFixed(2);
}
