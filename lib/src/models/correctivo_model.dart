import 'dart:convert';

class Correctivo {
  String _id;
  String name;
  String severidad;
  String image;
  int nroPersonas;
  Correctivo({this.name, this.nroPersonas, this.severidad, this.image});
  String get id => _id;

  @override
  String toString() => "Record<$name:$nroPersonas:$severidad>";
  factory Correctivo.fromMap(Map<String, dynamic> json) => new Correctivo(
        name: json["name"],
        nroPersonas: json["nroPersonas"],
        severidad: json["severidad"],
        image: json["image"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "nroPersonas": nroPersonas,
        "severidad": severidad,
        "image": image,
      };
}

Correctivo correctivoFromJson(String str) =>
    Correctivo.fromMap(json.decode(str));
String correctivoToJson(Correctivo data) => json.encode(data.toMap());
