import 'package:flutter/material.dart';
import 'favoritos.dart';
import 'perfil.dart';
import 'my_home_page.dart';
import 'opinion.dart';
import 'package:cafemixes/utils/colors.dart';

class Buscar extends StatefulWidget {
  @override
  _BuscarState createState() => _BuscarState();
}

class _BuscarState extends State<Buscar> {
  final List<Map<String, String>> allRecipes = [
    {
      'title': 'Frappe Chocolate',
      'description': 'Frappe con sabor a chocolate',
    },
    {
      'title': 'Latte Vainilla',
      'description': 'Café con leche y un toque de vainilla',
    },
    {
      'title': 'Cappuccino',
      'description': 'Café con leche espumosa y canela',
    },
    {
      'title': 'Moka',
      'description': 'Café con chocolate y crema',
    },
  ];

  List<Map<String, String>> filteredRecipes = [];
  TextEditingController _searchController = TextEditingController();
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    filteredRecipes = allRecipes;
    _searchController.addListener(_filterRecipes);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterRecipes);
    _searchController.dispose();
    super.dispose();
  }

  void _filterRecipes() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredRecipes = allRecipes
          .where((recipe) =>
              recipe['title']!.toLowerCase().contains(query) ||
              recipe['description']!.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.search),
        title: Text('Buscar Recetas'),
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
                MaterialPageRoute(builder: (context)=> MyHomePage()),
                );
              }
            ),
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
                  MaterialPageRoute(builder: (context)=> FavoritesScreen()),
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Buscar',
                hintText: 'Ingrese el nombre de la receta',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredRecipes.length,
              itemBuilder: (context, index) {
                final recipe = filteredRecipes[index];
                return ListTile(
                  title: Text(recipe['title']!),
                  subtitle: Text(recipe['description']!),
                  onTap: () {
                    // Lógica para ir a la pantalla de detalles de la receta
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeDetailScreen(
                          title: recipe['title']!,
                          description: recipe['description']!,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RecipeDetailScreen extends StatelessWidget {
  final String title;
  final String description;

  RecipeDetailScreen({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            description,
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
