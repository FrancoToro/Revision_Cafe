import 'package:cafemixes/pages/ViewerScreen.dart';
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
import 'ViewerScreen.dart';

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
              decoration: BoxDecoration(color: Color.fromARGB(128, 64, 0, 0)),
              child: Text(
                'Menú',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            _buildDrawerItem(Icons.home, 'Inicio', () => Navigator.pop(context)),
            _buildDrawerItem(
                Icons.account_circle, 'Perfil', () => _navigateTo(context, Perfil())),
            _buildDrawerItem(Icons.favorite, 'Favoritos',
                () => _navigateTo(context, FavoritesScreen())),
            _buildDrawerItem(Icons.grade, 'Opinion',
                () => _navigateTo(context, CuestionarioScreen())),
          ],
        ),
      ),
      body: FutureBuilder<List<Receta>>(
        future: recetas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error al cargar las recetas: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No tienes recetas aún.', style: TextStyle(fontSize: 18)),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final recipe = snapshot.data![index];
                  return _buildRecipeCard(context, recipe);
                },
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateTo(context, CreateRecipeScreen()),
        tooltip: 'Crear Receta',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }

   void _navigateTo(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  Widget _buildRecipeCard(BuildContext context, Receta recipe) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: (){
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=> ViewerScreen(recipe: recipe)),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.network(
                  recipe.imagen,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Center(child: Icon(Icons.broken_image, size: 50));
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.nombre,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    recipe.descripcion,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.favorite, color: Colors.red, size: 24),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
