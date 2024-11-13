import 'package:cafemixes/utils/DatabaseHelper.dart';
import 'package:flutter/material.dart';
import 'favoritos.dart';
import 'buscar.dart';
import 'mibarista.dart';
import 'my_home_page.dart';
import 'opinion.dart';
import 'Crearreceta.dart'; 
import 'package:cafemixes/utils/colors.dart';
import 'package:cafemixes/model/Receta.dart';

class Misrecetas extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final Future<List<Receta>> recetas = DatabaseHelper.GetRecipes();

    return Scaffold(
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: const Color.fromARGB(128, 64, 0, 0),
              ),
              child: Text(
                'Menú',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Inicio'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Mi barista'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Perfil()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Favoritos'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FavoritesScreen()),
                ); // Cierra el Drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.grade),
              title: Text('Opinion'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=> CuestionarioScreen()),
                ); // Cierra el Drawer
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Mis Recetas'), // Puedes mostrar tus recetas aquí
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateRecipeScreen()), // Asegúrate de que esta pantalla exista
          );
        },
        tooltip: 'Crear Receta',
        child: Icon(Icons.add), // Icono para crear una nueva receta
      ),
    );
  }
}
