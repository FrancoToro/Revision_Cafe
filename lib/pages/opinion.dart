import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:cafemixes/model/Cuestionario.dart';
import 'package:cafemixes/utils/colors.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

import 'favoritos.dart';
import 'buscar.dart';
import 'ViewerScreen.dart';
import 'LatteScreen.dart';
import 'mibarista.dart';
import 'opinion.dart';
import 'my_home_page.dart';


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
        backgroundColor:  CafeColors.Cafe.shade400,
        leading: Icon(Icons.grade),
        title: Text("Opinion"),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color:  CafeColors.Cafe.shade900,
              ),
              child: Text(
                'Menú',
                style: TextStyle(
                  color:  CafeColors.Cafe.shade100,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=> MyHomePage()),
                ); 
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Mi barista'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Perfil()), 
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Mi barista'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FavoritesScreen()), // Reemplaza FavoritesScreen con tu clase correcta
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.ad_units_outlined),
              title: Text('Receta'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=> LatteScreen()),
                ); 
              },
            ),
          ],
        ),
      ),

        
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

  void _submit() async {
  // Genera el contenido del correo con las respuestas del cuestionario
  String mensaje = 'Respuestas del Cuestionario:\n\n';
  mensaje += 'Sección: Usabilidad\n';
  for (var pregunta in _cuestionario!.usabilidad) {
    mensaje += '${pregunta.titulo}: ${pregunta.valor} estrellas\n';
  }
  mensaje += '\nSección: Contenido\n';
  for (var pregunta in _cuestionario!.contenido) {
    mensaje += '${pregunta.titulo}: ${pregunta.valor} estrellas\n';
  }

  // Crea el correo
  final email = Email(
    subject: 'Resultados del Cuestionario',
    body: mensaje,
    recipients: ['torowinner11@gmail.com'], // Reemplaza con el correo del desarrollador
  );

  try {
    // Envía el correo
    await FlutterEmailSender.send(email);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Respuestas enviadas con éxito')),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error al enviar las respuestas: $e')),
    );
  }
}
}
