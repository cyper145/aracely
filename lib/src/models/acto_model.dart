import 'package:nusaramina/src/models/correctivo_model.dart';

import 'dart:convert';

Acto actoFromJson(String str) => Acto.fromMap(json.decode(str));

String actoToJson(Acto data) => json.encode(data.toMap());

class Acto {
  String _id;
  String codigo;
  String name;
  String image;
  int nroPersonas;
  String severidad;
  String tipo;
  List<Correctivo>
      correctivos; // ya que un puede tener varios correctivos inicialmete va solo uno

  Acto(
      {this.name,
      this.tipo,
      this.nroPersonas,
      this.severidad,
      this.image,
      this.codigo,
      this.correctivos});
  String get id => _id;

  @override
  String toString() => "Record<$name:$nroPersonas:$severidad>";
  factory Acto.fromMap(Map<String, dynamic> json) => new Acto(
        name: json["name"],
        tipo: json["tipo"],
        nroPersonas: json["nroPersonas"],
        severidad: json["severidad"],
        image: json["image"],
        codigo: json["codigo"],
        correctivos: List<Correctivo>.from(json["correctivos"].map((x) {
          Map<String, dynamic> js = Map<String, dynamic>.from(x);
          return Correctivo.fromMap(js);
        })),
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "tipo": tipo,
        "nroPersonas": nroPersonas,
        "severidad": severidad,
        "image": image,
        "codigo": codigo,
        "correctivos": correctivos,
      };
}

Concidencias concidenciaFromJson(String str) =>
    Concidencias.fromMap(json.decode(str));

String concidenciaToJson(Concidencias data) => json.encode(data.toMap());

class Concidencias {
  String codigo;
  int nroConcidencias;

  Concidencias({this.codigo, this.nroConcidencias});
  factory Concidencias.fromMap(Map<String, dynamic> json) => new Concidencias(
        codigo: json["codigo"],
        nroConcidencias: json["nroConcidencias"],
      );

  Map<String, dynamic> toMap() => {
        "codigo": codigo,
        "nroConcidencias": nroConcidencias,
      };
}
