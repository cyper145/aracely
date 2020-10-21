import 'package:flutter/material.dart';
import 'package:nusaramina/src/bloc/nus_bloc.dart';
import 'package:nusaramina/src/bloc/provider.dart';
import 'package:nusaramina/src/models/nus_model.dart';

import 'dart:math';
import 'dart:ui';

import 'package:nusaramina/src/preferencias_usuario/preferencias_usuario.dart';

class DashboardPage extends StatelessWidget {
  NusBloc nusBloc;
  PreferenciasUsuario preferenciasUsuario = PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    nusBloc = Provider.nusBloc(context);
    return Scaffold(
        body: Stack(
          children: <Widget>[
            _fondoApp(),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[_titulos(), _botonesRedondeados(context)],
              ),
            )
          ],
        ),
        bottomNavigationBar: _bottomNavigationBar(context));
  }

  Widget _fondoApp() {
    final gradiente = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: FractionalOffset(0.0, 0.6),
              end: FractionalOffset(0.0, 1.0),
              colors: [
            Color.fromRGBO(89, 182, 171, 1.0),
            Color.fromRGBO(89, 182, 171, 1.0)
          ])),
    );

    final cajaRosa = Transform.rotate(
        angle: -pi / 5.0,
        child: Container(
          height: 360.0,
          width: 360.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(80.0),
              gradient: LinearGradient(colors: [
                Color.fromRGBO(42, 43, 143, 0.56),
                Color.fromRGBO(129, 131, 219, 0.86),
              ])),
        ));

    return Stack(
      children: <Widget>[gradiente, Positioned(top: -100.0, child: cajaRosa)],
    );
  }

  Widget _titulos() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                'HERRAMIENTA DE GESTIÓN AUTOMATIZADA',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: Text('NÚMERO DE SEGURIDAD (NUS)',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 10.0),
            Text(
                'Dinámica de Actos y Condiciones Subestandares y Determinación de Medidas de Control ',
                style: TextStyle(color: Colors.white, fontSize: 18.0)),
          ],
        ),
      ),
    );
  }

  Widget _bottomNavigationBar(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          canvasColor: Color.fromRGBO(58, 56, 97, 1),
          primaryColor: Color.fromRGBO(89, 182, 171, 1.0),
          textTheme: Theme.of(context)
              .textTheme
              .copyWith(caption: TextStyle(color: Colors.white))),
      child: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today, size: 30.0),
            title: Text(
              'INICIO',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bubble_chart, size: 30.0),
            title: Text(
              'GRUPO',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle, size: 30.0),
            title: Text(
              'INFORMACION',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget _botonesRedondeados(BuildContext context) {
    return Table(
      children: [
        TableRow(children: [
          _crearBotonRedondeado(
              context, Colors.blue, Icons.border_all, 'NUS', 'nus'),
          _crearBotonRedondeado(context, Colors.pinkAccent, Icons.score,
              'ESTADISTICAS', 'estadisticas'),
        ]),
        TableRow(children: [
          _crearBotonRedondeado(
              context, Colors.purpleAccent, Icons.list, 'LISTA DE NUS', 'nus'),
          _crearBotonRedondeado(context, Colors.orange, Icons.assignment,
              'NUS GLOBALES', 'globales'),
        ]),
      ],
    );
  }

  Widget _crearBotonRedondeado(BuildContext context, Color color,
      IconData icono, String texto, String router) {
    //siempre cargar  todo los nus en general
    return StreamBuilder(
        stream: nusBloc.nusStream,
        builder: (context, AsyncSnapshot<List<Nus>> snapshot) {
          if (snapshot.hasData) {
            // lista de todos los nus
            final lisNus = snapshot.data;

            Nus data;
            if (router == "nus") {
              data = lisNus[0]; // escogerel primero
            }

            return GestureDetector(
              onTap: () => Navigator.pushReplacementNamed(context, router,
                  arguments: data == null ? lisNus : data),
              child: Container(
                height: 150.0,
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(83, 81, 131, 0.7),
                    borderRadius: BorderRadius.circular(20.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SizedBox(height: 5.0),
                    CircleAvatar(
                      backgroundColor: color,
                      radius: 40.0,
                      child: Icon(icono, color: Colors.white, size: 50.0),
                    ),
                    Text(texto,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 5.0)
                  ],
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
