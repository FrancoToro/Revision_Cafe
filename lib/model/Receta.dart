import 'dart:convert';

class Receta {
  late int id;
  late String nombre;
  late String descripcion;
  late List<String> ingredientes;
  late List<String> productos;
  late List<String> pasos;
  late int rating;
  late bool favorita;
  late String imagen;

  Receta(this.nombre, this.descripcion,this.ingredientes,this.productos,this.pasos,this.imagen );

  //crear version para meter a base de datos
  Map<String, dynamic> toJson()
  {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'ingredientes': ingredientes,
      'pasos': pasos,
      'rating': rating,
      'imagen': imagen
    };
  }



  Receta.fromJson(Map<String,dynamic> json, {bool f = false}) :
  id = json['id'] as int,
  nombre = json['nombre'] as String,
  descripcion = json['descripcion'] as String,
  ingredientes = json['ingredientes'] as List<String>,
  productos = json['productos'] as List<String>,
  pasos = json['pasos'] as List<String>,
  rating = json['rating'] as int,
  {
    fav = f;
  }


  void agregarIngrediente(String ingrediente)
  {
    if (ingrediente.isNotEmpty) ingredientes.add(ingrediente);
  }

  void agregarPaso(String paso)
  {
    if (paso.isNotEmpty) ingredientes.add(paso);
  }

  void marcarComoFavorito()
  {
    favorita = true;
  }

  void desmarcarComoFavorito()
  {
    favorita = false;
  }

  Future<void> UpdateInDatabase()
  {
    return DatabaseHelper.updateRecipe(this);
  }
}
