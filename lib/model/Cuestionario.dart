class Pregunta {
  final String titulo;
  late int valor;
  final String min;
  final String max;

  Pregunta({required this.titulo, required this.valor, required this.min, required this.max});

  factory Pregunta.fromJson(Map<String, dynamic> json) {
    return Pregunta(
      titulo: json['titulo'],
      valor: json['valor'],
      min: json['min'],
      max: json['max'],
    );
  }
}

class Cuestionario {
  final List<Pregunta> usabilidad;
  final List<Pregunta> contenido;

  Cuestionario({required this.usabilidad, required this.contenido});

  factory Cuestionario.fromJson(Map<String, dynamic> json) {
    return Cuestionario(
      usabilidad: (json['usabilidad'] as List).map((i) => Pregunta.fromJson(i)).toList(),
      contenido: (json['contenido'] as List).map((i) => Pregunta.fromJson(i)).toList(),
    );
  }
}
