import 'package:flutter/material.dart';
import 'favoritos.dart';
import 'buscar.dart';
import 'perfil.dart';
import 'my_home_page.dart';

class LatteScreen extends StatefulWidget {
  @override
  _LatteScreenState createState() => _LatteScreenState();
}

class _LatteScreenState extends State<LatteScreen> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Receta: Latte Vainilla'),
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
              leading: Icon(Icons.search),
              title: Text('Buscar'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Buscar()),
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
                  'https://osterstatic.reciperm.com/webp/10101.webp',
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Latte Vainilla',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Café con leche y un toque de vainilla.',
                style: TextStyle(fontSize: 16),
              ),
              Divider(height: 32, color: Colors.black),
              Text(
                'Ingredientes',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('- 1 taza de leche'),
              SizedBox(height: 8),
              Text('- 1 taza de café espresso'),
              SizedBox(height: 8),
              Text('- 1 cucharadita de esencia de vainilla'),
              SizedBox(height: 8),
              Text('- 2 cucharadas de azúcar o al gusto'),
              SizedBox(height: 8),
              Text('- Canela en polvo para decorar (opcional)'),
              Divider(height: 32, color: Colors.black),
              Text(
                'Instrucciones',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('1. Calienta la leche en una olla a fuego medio hasta que esté caliente, pero sin que hierva. Luego Añade la esencia de vainilla y el azúcar a la leche caliente, y mezcla bien.'),
              SizedBox(height: 8),
              Text('2. Prepara el café espresso y viértelo en una taza grande.'),
              SizedBox(height: 8),
              Text('3. Vierte la leche caliente sobre el café, formando una capa de espuma en la parte superior.'),
              SizedBox(height: 8),
              Text('4. Decora con un poco de canela en polvo si lo deseas. Disfruta.'),
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
