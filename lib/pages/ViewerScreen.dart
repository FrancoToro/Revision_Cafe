import 'package:cafemixes/utils/DatabaseHelper.dart';
import 'package:flutter/material.dart';
import 'favoritos.dart';
import 'buscar.dart';
import 'mibarista.dart';
import 'my_home_page.dart';
import 'package:cafemixes/model/Receta.dart';

// Escena de recetas
class ViewerScreen extends StatefulWidget {
  final Receta recipe;

  const ViewerScreen({super.key, required this.recipe});

  @override
  State<StatefulWidget> createState() => _viewerState(recipe);

}

class _viewerState extends State<ViewerScreen>
{
  _viewerState(Receta r) : recipe=r;

  Receta recipe;

  @override
  Widget build(BuildContext context) {
    const snackbar = SnackBar(content: Text("Has calificado esta receta"));
    return Scaffold(
      appBar: AppBar(
        title: Text('Receta: ${recipe.nombre}'),
      ),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Perfil'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Perfil()), // Asegúrate de que Perfil esté importado
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
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  recipe.imagen,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '${recipe.nombre}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '${recipe.descripcion}',
                style: TextStyle(fontSize: 16),
              ),
              Divider(height: 32, color: Colors.black),
              Text(
                'Ingredientes',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              SizedBox(
                height: 100, // Ajusta la altura según necesites
                child: ListView.builder(
                  itemCount: recipe.ingredientes.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(recipe.ingredientes[index]),
                    );
                  },
                ),
              ),
              Divider(height: 32, color: Colors.black),
              Text(
                'Instrucciones',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              SizedBox(
                height: 200, // Ajusta la altura según necesites
                child: ListView.builder(
                  itemCount: recipe.pasos.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(recipe.pasos[index]),
                    );
                  },
                ),
              ),
              // Descomenta y define la lógica de calificación si deseas implementarla
              SizedBox(height: 32),
              Text(
                'Califica esta receta:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      recipe.rating > index ? Icons.star : Icons.star_border,
                      color: Colors.yellow,
                    ),
                    onPressed: () {
                      Calificar(index); // Calificación de 1 a 5
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void Calificar(int index)
  {
    setState(() {
      recipe.rating = index + 1; // Calificación de 1 a 5
      DatabaseHelper.updateRecipe(recipe);
    });
  }
}
