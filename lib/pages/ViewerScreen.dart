import 'package:flutter/material.dart';
import 'favoritos.dart';
import 'buscar.dart';
import 'mibarista.dart';
import 'my_home_page.dart';
import 'package:cafemixes/model/Receta.dart';

//escena recetas
class ViewerScreen extends StatefulWidget {
  
  final Receta recipe;

  const ViewerScreen(this.recipe);

  @override
  _ViewerScreenState createState() => _ViewerScreenState();
}

class _ViewerScreenState extends State<ViewerScreen> {
  int _rating = 0; // Calificación inicial

  void _rateRecipe(int rating) {
    setState(() {
      _rating = rating;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Has calificado esta receta con $_rating estrella${_rating > 1 ? 's' : ''}.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    Receta r = widget.recipe;

    return Scaffold(
      appBar: AppBar(
        title: Text('Receta: ${r.nombre}'),
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
                }),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Perfil'),
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
                  r.imagen,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '${r.nombre}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '${widget.recipe.descripcion}',
                style: TextStyle(fontSize: 16),
              ),
              Divider(height: 32, color: Colors.black),
              Text(
                'Ingredientes',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              ListView.builder(
                itemCount: r.ingredientes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(r.ingredientes[index])
                  );
                }
              ),
              Divider(height: 32, color: Colors.black),
              Text(
                'Instrucciones',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              ListView.builder(
                itemCount: r.pasos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(r.pasos[index])
                  );
                }
              ),
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
                      _rating > index ? Icons.star : Icons.star_border,
                      color: Colors.yellow,
                    ),
                    onPressed: () {
                      _rateRecipe(index + 1); // Calificación de 1 a 5
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
}
