import 'dart:io';

import 'package:nusaramina/src/models/acto_model.dart';
import 'package:nusaramina/src/models/nus_model.dart';
import 'package:nusaramina/src/providers/nus_provider.dart';

import 'package:rxdart/rxdart.dart';

class NusBloc {
  final _nusController = new BehaviorSubject<List<Nus>>();
  final _nusPageController = new BehaviorSubject<List<Nus>>();
  final _actoController = new BehaviorSubject<List<Acto>>();
  final _cargandoController = new BehaviorSubject<bool>();

  final _nusProvider = new NusProvider();

  Stream<List<Nus>> get nusStream => _nusController.stream;
  Stream<bool> get cargando => _cargandoController.stream;
  Stream<List<Acto>> get actoStream => _actoController.stream;

  void cargarNus() async {
    final nus = await _nusProvider.cargarNus();
    _nusController.sink.add(nus);
  }

  void cargarNusPage(String documentId) async {
    final nus = await _nusProvider.cargarNus();
    _nusController.sink.add(nus);
  }

  void agregarNus(Nus nus) async {
    _cargandoController.sink.add(true);
    await _nusProvider.crearNus(nus);
    _cargandoController.sink.add(false);
  }

  Future<String> subirFoto(File foto) async {
    _cargandoController.sink.add(true);
    final fotoUrl = await _nusProvider.subirImagen(foto);
    _cargandoController.sink.add(false);

    return fotoUrl;
  }

  void editarNus(Nus nus) async {
    _cargandoController.sink.add(true);
    await _nusProvider.editarNus(nus);
    _cargandoController.sink.add(false);
  }

  void borrarNus(String id) async {
    await _nusProvider.borrarNus(id);
  }

  //====== methos de actos
  void cargarActos(String documentoId) async {
    final nus = await _nusProvider.cargarNus();
    _nusController.sink.add(nus);
  }

  dispose() {
    _nusController?.close();
    _cargandoController?.close();
    _actoController?.close();
    _nusPageController?.close();
  }
}
