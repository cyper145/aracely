import 'dart:io';

import 'package:flutter/material.dart';

import 'package:nusaramina/src/bloc/nus_bloc.dart';
import 'package:nusaramina/src/bloc/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nusaramina/src/models/acto_model.dart';
import 'package:nusaramina/src/models/nus_model.dart';

import 'package:nusaramina/src/utils/utils.dart' as utils;
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

class ActoPage extends StatefulWidget {
  @override
  _ActoPageState createState() => _ActoPageState();
}

class _ActoPageState extends State<ActoPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  NusBloc nusBloc;
  Nus nus = new Nus();
  bool _guardando = false;
  File foto;
  AutoCompleteTextField searchTextField;
  GlobalKey<AutoCompleteTextFieldState<Acto>> key = new GlobalKey();

  bool selectedRadio1 = false;
  bool selectedRadio2 = false;
  bool selectedRadio3 = false;
  int selectedRadioTile;
  //variables para el crud

  Map<String, Color> _mapcolors = {
    '': Colors.white,
    '0.33': Colors.green,
    '1.00': Colors.yellow[800],
    '3.00': Colors.red,
  };

  String severidad;
  @override
  Widget build(BuildContext context) {
    nusBloc = Provider.nusBloc(context);
    // final ProductoModel prodData = ModalRoute.of(context).settings.arguments;
    // if ( prodData != null ) {
    //  producto = prodData;
    //}

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('ACTO',
            style: TextStyle(
              color: Colors.white,
            )),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual, color: Colors.white),
            onPressed: _seleccionarFoto,
          ),
          IconButton(
            icon: Icon(
              Icons.camera_alt,
              color: Colors.white,
            ),
            onPressed: _tomarFoto,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                //_mostrarFoto(),
                _crearNombre(),
                /*
                 !loading
                  ? CircularProgressIndicator()
                  : searchTextField = textAutocomplete(context),}
                  */
                _crearTipoActo(),
                _crearSeveridad(),
                _crearNroPersonas(),
                _crearBoton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: nus.codigo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Acto',
      ),
      onSaved: (value) => nus.codigo = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el nombre del producto';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearTipoActo() {
    return TextFormField(
      initialValue: nus.codigo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Tipo',
      ),
      onSaved: (value) => nus.codigo = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el nombre del producto';
        } else {
          return null;
        }
      },
    );
  }

/*
  Widget textAutocomplete(BuildContext context) {
    
    if (listConvertidos != null) {
      return AutoCompleteTextField<Acto>(
        key: key,
        clearOnSubmit: false,
        suggestions: listConvertidos,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            hintText: 'Escriba el tipo',
            labelText: 'Tipo',
            prefixIcon: Icon(Icons.category)),
        itemFilter: (item, query) {

          
          return item.name.toLowerCase().contains(query.toLowerCase());
        },
        itemSorter: (a, b) {
          return a.name.compareTo(b.name);
        },
        itemSubmitted: (item) {
          setState(() {
            searchTextField.textField.controller.text = item.name;
            tipo = item.name;
            codigo = item.codigo;
          });
        },
        itemBuilder: (context, item) {
          return row(item);
        },
      );
    } else {
      return Container();
    }
  }

*/

  Widget _crearSeveridad() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(5),
          child: Title(
            title: 'Severidad',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 7,
                ),
                Icon(
                  Icons.security,
                  semanticLabel: 'Severidad',
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(
                  width: 12,
                ),
                SizedBox(
                  width: 100,
                  child: Text(
                    'Severidad',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                )
              ],
            ),
            color: Colors.purpleAccent,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Flexible(
                fit: FlexFit.tight,
                child: RadioListTile(
                  dense: true,
                  value: 1,
                  groupValue: selectedRadioTile,
                  title: Text("0.33"),
                  onChanged: (val) {
                    print("Radio Tile pressed $val");
                    _setSelectedRadioTile(val);
                  },
                  activeColor: _mapcolors['0.33'],
                  selected: selectedRadio1,
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: RadioListTile(
                  dense: true,
                  value: 2,
                  groupValue: selectedRadioTile,
                  title: Text("1.00"),
                  onChanged: (val) {
                    print("Radio Tile pressed $val");
                    _setSelectedRadioTile(val);
                  },
                  activeColor: _mapcolors['1.00'],
                  selected: selectedRadio2,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                fit: FlexFit.loose,
                child: RadioListTile(
                  dense: true,
                  value: 3,
                  groupValue: selectedRadioTile,
                  title: Text("3.00"),
                  onChanged: (val) {
                    print("Radio Tile pressed $val");
                    _setSelectedRadioTile(val);
                  },
                  activeColor: _mapcolors['3.00'],
                  selected: selectedRadio3,
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  _setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
      switch (val) {
        case 1:
          selectedRadio1 = true;
          selectedRadio2 = false;
          selectedRadio3 = false;
          this.severidad = '0.33';
          break;
        case 2:
          selectedRadio1 = false;
          selectedRadio2 = true;
          selectedRadio3 = false;
          this.severidad = '1.00';
          break;
        case 3:
          selectedRadio1 = false;
          selectedRadio2 = false;
          selectedRadio3 = true;
          this.severidad = '3.00';
          break;
        default:
      }
    });
  }

  Widget _crearNroPersonas() {
    return TextFormField(
      initialValue: nus.codigo.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: '#Personas'),
      onSaved: (value) => nus.codigo = value,
      validator: (value) {
        if (utils.isNumeric(value)) {
          return null;
        } else {
          return 'Sólo números';
        }
      },
    );
  }

  Widget _crearBoton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Color.fromRGBO(42, 43, 143, 0.56),
      textColor: Colors.white,
      label: Text('Guardar'),
      icon: Icon(Icons.save),
      onPressed: (_guardando) ? null : _submit,
    );
  }

  void _submit() async {
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();

    setState(() {
      _guardando = true;
    });
    /*
    if ( foto != null ) {
      producto.fotoUrl = await productosBloc.subirFoto(foto);
    }
    */
    if (nus.documentoId == null) {
      nusBloc.agregarNus(nus);
    } else {
      nusBloc.editarNus(nus);
    }

    // setState(() {_guardando = false; });
    mostrarSnackbar('Registro guardado');

    Navigator.pop(context);
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  Widget _mostrarFoto() {
    /*
    if ( producto.fotoUrl != null ) {  
      return FadeInImage(
        image: NetworkImage( producto.fotoUrl ),
        placeholder: AssetImage('assets/jar-loading.gif'),
        height: 300.0,
        fit: BoxFit.contain,
      );

    } else {

      return Image(

        image: AssetImage( foto?.path ?? 'assets/no-image.png'),
        height: 300.0,
        fit: BoxFit.cover,

      );

    }
    */
  }

  _seleccionarFoto() async {
    _procesarImagen(ImageSource.gallery);
  }

  _tomarFoto() async {
    _procesarImagen(ImageSource.camera);
  }

  _procesarImagen(ImageSource origen) async {
    foto = await ImagePicker.pickImage(source: origen);
    /*
    if ( foto != null ) {
      producto.fotoUrl = null;
    }
    */
    setState(() {});
  }
}
