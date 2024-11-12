import 'package:flutter/material.dart';
import 'package:cafemixes/utils/colors.dart';

class CreateRecipeScreen extends StatefulWidget {
  @override
  _CreateRecipeScreenState createState() => _CreateRecipeScreenState();
}

class _CreateRecipeScreenState extends State<CreateRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  String _recipeTitle = '';
  String _recipeDescription = '';
  String _recipeIngredients = '';
  String _recipeImageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  CafeColors.Cafe.shade200,
        title: Text("Crear Receta"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Título de la Receta',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un título';
                  }
                  return null;
                },
                onSaved: (value) {
                  _recipeTitle = value!;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Descripción de la Receta',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa una descripción';
                  }
                  return null;
                },
                onSaved: (value) {
                  _recipeDescription = value!;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Ingredientes',
                  hintText: 'Lista los ingredientes separados por comas',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa los ingredientes';
                  }
                  return null;
                },
                onSaved: (value) {
                  _recipeIngredients = value!;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Receta paso a paso',
                  border: OutlineInputBorder(),
                ),
                maxLines: 10,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresar paso a paso';
                  }
                  return null;
                },
                onSaved: (value) {
                  _recipeDescription = value!;
                },
              ),
              SizedBox(height: 16),
              
              Row(
                children: [
                ElevatedButton(
                  onPressed: (){},
                  child: Icon(Icons.add_a_photo)
                ),
                SizedBox(width: 30),
                Text('Subir Fotos'),
                ]
              ),
              
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Aquí puedes guardar la receta, por ejemplo, enviarla a un backend o guardarla localmente.
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Receta guardada con éxito'),
                      ),
                    );
                  }
                },
                child: Text('Guardar Receta'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CreateRecipeScreen(),
  ));
}
