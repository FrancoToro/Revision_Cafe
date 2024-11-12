import 'dart:convert';

class Receta {
  late int id;
  late String nombre;
  late String descripcion;
  late List<String> ingredientes;
  late List<String> productos;
  late List<String> pasos;
  late bool favorita;
  late String imagen;

  //crear version para meter a base de datos
  Map<String, dynamic> toJson()
  {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'ingredientes': ingredientes,
      'pasos': pasos,
      'favorita': favorita
    };
  }

  Receta.fromJson(Map<String,dynamic> json) :
  id = json['id'] as int,
  nombre = json['nombre'] as String,
  descripcion = json['descripcion'] as String,
  ingredientes = json['ingredientes'] as List<String>,
  productos = json['productos'] as List<String>,
  pasos = json['pasos'] as List<String>,
  favorita = json['favorita'] as bool;


  void agregarIngrediente(String ingrediente) {
  }

  void agregarPaso(String paso) {
  }

  void marcarComoFavorito()
  {
    favorita = true;
  }

  void desmarcarComoFavorito()
  {
    favorita = false;
  }
}
