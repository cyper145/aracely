import 'package:flutter/material.dart';

import 'package:nusaramina/src/bloc/login_bloc.dart';
import 'package:nusaramina/src/bloc/nus_bloc.dart';
export 'package:nusaramina/src/bloc/login_bloc.dart';

import 'package:nusaramina/src/bloc/productos_bloc.dart';
export 'package:nusaramina/src/bloc/productos_bloc.dart';

//
class Provider extends InheritedWidget {
  final loginBloc = new LoginBloc();
  final _productosBloc = new ProductosBloc();
  final _nusBloc = new NusBloc();

  static Provider _instancia;

  factory Provider({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new Provider._internal(key: key, child: child);
    }
    return _instancia;
  }

  Provider._internal({Key key, Widget child}) : super(key: key, child: child);

  // Provider({ Key key, Widget child })
  //   : super(key: key, child: child );

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)
        .loginBloc;
  }

  static ProductosBloc productosBloc(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)
        ._productosBloc;
  }

  static NusBloc nusBloc(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)
        ._nusBloc;
  }
}
