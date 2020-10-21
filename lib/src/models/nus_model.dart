import 'dart:convert';
import 'package:nusaramina/src/models/acto_model.dart';

Nus nusFromJson(String str) => Nus.fromMap(json.decode(str));

String nusToJson(Nus data) => json.encode(data.toMap());

class Nus {
  String documentoId;
  String codigo;
  String fecha;
  List<Acto> actos;
  List<Concidencias> concidencias;
  //String idUsuarioCreador;
  //String idUsuarioCulminador;
  String resumenActo;
  String resumenCorrectivo;
  String estado;

  Nus(
      {this.documentoId,
      this.codigo,
      this.fecha,
      this.actos,
      this.concidencias,
      this.resumenActo,
      this.resumenCorrectivo,
      this.estado});

  @override
  String toString() => "Record<$fecha:$resumenActo:$resumenCorrectivo>";
  factory Nus.fromMap(Map<String, dynamic> json) => Nus(
        codigo: json["codigo"],
        fecha: json["fecha"],
        resumenActo: json["resumenActo"],
        resumenCorrectivo: json["resumenCorrectivo"],
        estado: json["estado"],
        actos: List<Acto>.from(json["actos"].map((x) {
          Map<String, dynamic> js = Map<String, dynamic>.from(x);
          return Acto.fromMap(js);
        })),
        concidencias: List<Concidencias>.from(json["concidencias"].map((x) {
          Map<String, dynamic> js = Map<String, dynamic>.from(x);
          return Concidencias.fromMap(js);
        })),
      );
// falta algunas cosas
  Map<String, dynamic> toMap() => {
        "codigo": codigo,
        "fecha": fecha,
        "resumenActo": resumenActo,
        "resumenCorrectivo": resumenCorrectivo,
        "estado": estado,
        "actos": new List<dynamic>.from(actos.map((x) => x.toMap())),
        "concidencias":
            new List<dynamic>.from(concidencias.map((x) => x.toMap())),
      };

  Acto verdata(Map<String, dynamic> x) {
    return Acto.fromMap(x);
  }

  compareTo(Nus fecha) {
    this.fecha.compareTo(fecha.fecha);
  }
}

//
Acto actoFromJson(String str) => Acto.fromMap(json.decode(str));
String actoToJson(Acto data) => json.encode(data.toMap());

class TimeSeriesSales {
  String time;
  int sales;

  TimeSeriesSales(this.time, this.sales);
}
