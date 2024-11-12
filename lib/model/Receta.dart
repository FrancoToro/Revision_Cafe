
class Receta {
  late int id;
  late String nombre;
  late String descripcion;
  late String ingredientes;
  late String pasos;
  late bool favorita;
  late String imagen;

  //crear version para meter a base de datos
  Map<String, Object?> toMap()
  {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'ingredientes': ingredientes,
      'pasos': pasos,
      'favorita': favorita ? 1 : 0
    };
  }

  Receta()
  {
    
  }

  void agregarIngrediente(String ingrediente) {
  }

  void agregarPaso(String paso) {
  }

  void marcarComoFavorito() {
  }

  void desmarcarComoFavorito() {
  }
}
