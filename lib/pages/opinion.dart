import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:cafemixes/model/Cuestionario.dart';
import 'package:cafemixes/utils/colors.dart';

class CuestionarioScreen extends StatefulWidget {
  @override
  _CuestionarioScreenState createState() => _CuestionarioScreenState();
}

class _CuestionarioScreenState extends State<CuestionarioScreen> {
  Cuestionario? _cuestionario;

  @override
  void initState() {
    super.initState();
    _loadCuestionario();
  }

  Future<void> _loadCuestionario() async {
    final String response = await rootBundle.loadString('assets/cuestionario.json');
    final data = json.decode(response);
    setState(() {
      _cuestionario = Cuestionario.fromJson(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_cuestionario == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor:  CafeColors.Cafe.shade300,
        title: Text("Cuestionario")),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Text("Sección: Usabilidad", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ..._buildPreguntas(_cuestionario!.usabilidad),
          SizedBox(height: 20),
          Text("Sección: Contenido", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ..._buildPreguntas(_cuestionario!.contenido),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submit,
            child: Text("Enviar respuestas"),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPreguntas(List<Pregunta> preguntas) {
    return preguntas.map((pregunta) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(pregunta.titulo, style: TextStyle(fontSize: 16)),
          Row(
            children: List.generate(5, (index) {
              return IconButton(
                icon: Icon(
                  index + 1 <= pregunta.valor ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                ),
                onPressed: () {
                  setState(() {
                    pregunta.valor = index + 1;
                  });
                },
              );
            }),
          ),
          Text("(${pregunta.min}) - (${pregunta.max})"),
          Divider(),
        ],
      );
    }).toList();
  }

  void _submit() {
    // Puedes implementar el código para guardar o procesar las respuestas aquí.
    print("Respuestas guardadas: ");
    for (var pregunta in _cuestionario!.usabilidad) {
      print('${pregunta.titulo}: ${pregunta.valor} estrellas');
    }
    for (var pregunta in _cuestionario!.contenido) {
      print('${pregunta.titulo}: ${pregunta.valor} estrellas');
    }
  }
}
