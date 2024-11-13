import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'favoritos.dart';
import 'buscar.dart';
import 'FrappeScreen.dart';
import 'LatteScreen.dart';
import 'mibarista.dart';
import 'opinion.dart';
import 'package:cafemixes/utils/colors.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key}); // Corrección del constructor
  
  @override
  
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
  int _selectedIndex = 0;
  List<String> _ultimasRecetas = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor:  CafeColors.Cafe.shade300,
        leading: SvgPicture.asset(
          'assets/icons/cafe.svg',
          width: 50, // Ajuste del tamaño
          height: 50,
        ),
        title: const Text("Cafe Mixes"),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
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
              leading: const Icon(Icons.account_circle),
              title: const Text('Perfil'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Perfil()), 
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.search),
              title: const Text('Buscar'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Buscar()), 
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
              leading: Icon(Icons.grade),
              title: Text('Opinion'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=> CuestionarioScreen()),
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
       body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Últimas recetas preparadas",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // Mostrar "Caso inicial" o la lista de recetas
            _ultimasRecetas.isEmpty
                ? const Text(
                    "Aún no has visto ninguna receta.",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: _ultimasRecetas.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_ultimasRecetas[index]),
                          leading: Icon(Icons.coffee),
                          onTap: () {
                            // Aquí puedes navegar a la pantalla de la receta seleccionada
                          },
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}