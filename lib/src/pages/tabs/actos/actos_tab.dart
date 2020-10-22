import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nusaramina/src/bloc/nus_bloc.dart';
import 'package:nusaramina/src/bloc/provider.dart';
import 'package:image_picker/image_picker.dart';

import 'package:nusaramina/src/models/nus_model.dart';
import 'package:nusaramina/src/utils/utils.dart' as utils;

class Actostab extends StatefulWidget {
  @override
  _ActostabState createState() => _ActostabState();
}

class _ActostabState extends State<Actostab> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  NusBloc nusBloc;
  Nus nus = new Nus();
  bool _guardando = false;
  File foto;

  @override
  Widget build(BuildContext context) {
    nusBloc = Provider.nusBloc(context);

    final Nus nusData = ModalRoute.of(context).settings.arguments;

    if (nusData != null) {
      nus = nusData;
      nusBloc.cargarActos(nus.documentoId);
    } else {
      nusBloc.cargarActos('M0uTTFqTHvqye0E4ikZ');
    }

    return Scaffold(
        key: scaffoldKey,
        floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.add,
            ),
            backgroundColor: Color.fromRGBO(83, 81, 139, 0.55),
            onPressed: () => Navigator.pushReplacementNamed(context, 'acto')),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromRGBO(62, 134, 122, 1.0),
          title: Chip(
            label: Text('NUS: '),
          ),
          actions: <Widget>[
            Chip(
              label: Text('NUS: ' + "10.00"),
            ),
            SizedBox(
              width: 3,
            ),
            Chip(
              label: Text('NUS: ' + "105.00"),
            ),
          ],
        ),
        body: _crearListado(nusBloc));
  }

  Widget _crearListado(NusBloc nusBloc) {
    return StreamBuilder(
      stream: nusBloc.nusStream,
      builder: (BuildContext context, AsyncSnapshot<List<Nus>> snapshot) {
        if (snapshot.hasData) {
          final productos = snapshot.data;

          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context, i) =>
                _crearItem(context, nusBloc, productos[i]),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, NusBloc nusBloc, Nus nus) {
    return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (direccion) => nusBloc.borrarNus(nus.documentoId),
        child: Card(
          child: Column(
            children: <Widget>[
              (foto.path == null)
                  ? Image(image: AssetImage('assets/no-image.png'))
                  : FadeInImage(
                      image: NetworkImage(nus.resumenActo),
                      placeholder: AssetImage('assets/jar-loading.gif'),
                      height: 300.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
              ListTile(
                title: Text('${nus.codigo} - ${nus.codigo}'),
                subtitle: Text(nus.documentoId),
                onTap: () =>
                    Navigator.pushNamed(context, 'producto', arguments: nus),
              ),
            ],
          ),
        ));
  }

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
      onPressed: () => Navigator.pushNamed(context, 'producto'),
    );
  }
}
