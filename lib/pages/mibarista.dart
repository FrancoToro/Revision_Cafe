import 'package:flutter/material.dart';
import 'favoritos.dart';
import 'buscar.dart';
import 'misrecetas.dart';
import 'opinion.dart';
import 'my_home_page.dart';
import 'package:cafemixes/utils/colors.dart';

class Perfil extends StatefulWidget {
  @override
  _PerfilState createState() => _PerfilState();
}
  int _selectedIndex = 0;

class _PerfilState extends State<Perfil>
    with SingleTickerProviderStateMixin {
  final String userName = "Nose quien";
  final String email = "Nquien@ejemplo.com";
  final String profileImageUrl =
      "https://www.w3schools.com/howto/img_avatar.png"; // URL de ejemplo para la imagen de perfil

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  CafeColors.Cafe.shade400,
        leading: Icon(Icons.account_circle),
        title: Text('Perfil de Usuario'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: "Perfil"),
            Tab(text: "Mis Recetas"),
          ],
        ),
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
              leading: Icon(Icons.favorite),
              title: Text('Favoritos'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FavoritesScreen()),
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
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildProfileTab(),  // Contenido de la pestaña "Perfil"
          Misrecetas(),   // Contenido de la pestaña "Mis Recetas"
        ],
      ),
    );
  }

  Widget _buildProfileTab() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(profileImageUrl),
            ),
            SizedBox(height: 16),
            Text(
              userName,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              email,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Acción para editar perfil
                print('Editar perfil');
              },
              child: Text('Editar Perfil'),
            ),
          ],
        ),
      ),
    );
  }
}
