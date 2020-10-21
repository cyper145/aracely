class TipoActo{
  String _id;
  String name;
  String tipo;
 
  TipoActo({this.name, this.tipo});
  String get id => _id;

  factory TipoActo.fromMap(Map<String, dynamic> json) => new TipoActo(
        name: json["name"],
        tipo: json["tipo"],
    
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "tipo": tipo,      
    };

}
class Concidencias{
  String codigo;
  int nroConcidencias;
  
  Concidencias({this.codigo,this.nroConcidencias });
  factory Concidencias.fromMap(Map<String, dynamic> json) => new Concidencias(
        codigo: json["codigo"],
        nroConcidencias: json["nroConcidencias"],
    );

    Map<String, dynamic> toMap() => {
        "codigo": codigo,
        "nroConcidencias": nroConcidencias,
      
    };
}