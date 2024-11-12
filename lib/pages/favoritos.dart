import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'FrappeScreen.dart';
import 'LatteScreen.dart';
import 'buscar.dart';
import 'my_home_page.dart';
import 'perfil.dart';
import 'Opinion.dart';
import 'package:cafemixes/utils/colors.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyFavoritesPage(),
    );
  }
}

class MyFavoritesPage extends StatefulWidget {
  @override
  _MyFavoritesPageState createState() => _MyFavoritesPageState();
}

class _MyFavoritesPageState extends State<MyFavoritesPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  // Lista de recetas de ejemplo
  final List<Map<String, String>> favoriteRecipes = [
    {
      'title': 'Frappe Chocolate',
      'description': 'Frappe con sabor a chocolate',
      'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPTtEaEnFb-Ko48_nTjuZLb86K0go1b8wcAQ&s',
      'status': 'Me gusta',
    },
    {
      'title': 'Latte Vainilla',
      'description': 'Café con leche y un toque de vainilla',
      'imageUrl': 'https://osterstatic.reciperm.com/webp/10101.webp',
      'status': 'Me gusta',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: Icon(Icons.favorite_border),
        title: Text("Mis Favoritos"),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey,
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
      body: _buildFavoritesBody(),
    );
  }

  Widget _buildFavoritesBody() {
    if (favoriteRecipes.isEmpty) {
      return Center(
        child: Text(
          'No tienes recetas favoritas aún.',
          style: TextStyle(fontSize: 18),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Número de columnas
            childAspectRatio: 0.8, // Ajusta el aspecto de las tarjetas
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: favoriteRecipes.length,
          itemBuilder: (context, index) {
            final recipe = favoriteRecipes[index];
            return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                onTap: () {
                  if (recipe['title'] == 'Frappe Chocolate') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FrappeScreen()),
                    );
                  } else if (recipe['title'] == 'Latte Vainilla') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LatteScreen()),
                    );
                  }
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(10)),
                        child: Image.network(
                          recipe['imageUrl']!,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            recipe['title']!,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            recipe['description']!,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 2, horizontal: 8),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 0, 0),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Stack( // Centrar el ícono
                          children: [
                          Icon(
                            Icons.favorite,
                            color: Colors.white, // Color del ícono
                            size: 32, // Tamaño del ícono
                              ),
                            ],
                          ),
                            
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
