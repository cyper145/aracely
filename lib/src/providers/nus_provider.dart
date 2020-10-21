import 'dart:convert';
import 'dart:io';

import 'package:nusaramina/src/models/nus_model.dart';
import 'package:nusaramina/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';

class NusProvider {
  final String _url = 'https://nusmina-485c2.firebaseio.com/';
  final _prefs = new PreferenciasUsuario();

  Future<bool> crearNus(Nus nus) async {
    //final url = '$_url/nus.json?auth=${ _prefs.token }';
    final url = '$_url/nus.json';
    final resp = await http.post(url, body: nusToJson(nus));

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<bool> editarNus(Nus nus) async {
    final url = '$_url/nus.json/${nus.documentoId}.json?auth=${_prefs.token}';

    final resp = await http.put(url, body: nusToJson(nus));

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<List<Nus>> cargarNus() async {
    //final url  = '$_url/nus.json?auth=${ _prefs.token }';
    print("holas");
    final url = '$_url/nus.json';
    final resp = await http.get(url);
    print(resp);
    print("holas2");
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    print(decodedData);
    final List<Nus> listNus = new List();

    if (decodedData == null)
      return [];
    else
      return [];
    if (decodedData['error'] != null) return [];
    decodedData.forEach((id, prod) {
      final nusTemp = Nus.fromMap(prod);
      nusTemp.documentoId = id;
      listNus.add(nusTemp);
    });

    // print( productos[0].id );

    return listNus;
  }

  Future<List<Nus>> cargarNusPage(String documentId) async {
    //final url  = '$_url/nus.json?auth=${ _prefs.token }';
    print("holas");
    final url = '$_url/nus.json';
    final resp = await http.get(url);
    print(resp);
    print("holas2");
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    print(decodedData);
    final List<Nus> listNus = new List();

    if (decodedData == null)
      return [];
    else
      return [];

    if (decodedData['error'] != null) return [];
    decodedData.forEach((id, prod) {
      final nusTemp = Nus.fromMap(prod);
      nusTemp.documentoId = id;
      listNus.add(nusTemp);
    });

    // print( productos[0].id );

    return listNus;
  }

  Future<int> borrarNus(String id) async {
    final url = '$_url/productos/$id.json?auth=${_prefs.token}';
    final resp = await http.delete(url);

    print(resp.body);

    return 1;
  }

  Future<String> subirImagen(File imagen) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dc0tufkzf/image/upload?upload_preset=cwye3brj');
    final mimeType = mime(imagen.path).split('/'); //image/jpeg

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath('file', imagen.path,
        contentType: MediaType(mimeType[0], mimeType[1]));

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Algo salio mal');
      print(resp.body);
      return null;
    }

    final respData = json.decode(resp.body);
    print(respData);

    return respData['secure_url'];
  }
}
