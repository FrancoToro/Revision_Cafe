import 'package:flutter/material.dart';
import 'package:cafemixes/utils/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cafemixes/utils/DatabaseHelper.dart';
import 'package:cafemixes/model/Receta.dart';

class CreateRecipeScreen extends StatefulWidget {
  @override
  _CreateRecipeScreenState createState() => _CreateRecipeScreenState();
}

class _CreateRecipeScreenState extends State<CreateRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  late String nombre;
  late String descripcion;
  late List<String> ingredientes;
  late List<String> productos;
  late List<String> pasos;
  late bool favorita;
  File? _selectedImage; // Variable para almacenar la imagen seleccionada

  final List<TextEditingController> _ingredientControllers = [];
  final List<TextEditingController> _productControllers = [];
  final List<TextEditingController> _stepControllers = [];

  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  void _addIngredientField() {
    setState(() {
      _ingredientControllers.add(TextEditingController());
    });
  }

  void _addProductField() {
    setState(() {
      _productControllers.add(TextEditingController());
    });
  }

  void _addStepField() {
    setState(() {
      _stepControllers.add(TextEditingController());
    });
  }

  void _clearControllers() {
    for (var controller in _ingredientControllers) {
      controller.dispose();
    }
    for (var controller in _productControllers) {
      controller.dispose();
    }
    for (var controller in _stepControllers) {
      controller.dispose();
    }
  }

  // Método para seleccionar una imagen de la galería
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        _imageFile = pickedFile;
      });
    }
  }

  @override
  void dispose() {
    _clearControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CafeColors.Cafe.shade200,
        title: Text("Crear Receta"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Título de la receta
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
                  nombre = value!;
                },
              ),
              SizedBox(height: 16),
              // Descripción de la receta
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
                  descripcion = value!;
                },
              ),
              SizedBox(height: 16),
               // Ingredientes
              Text("Ingredientes"),
              ..._ingredientControllers.map((controller) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                      labelText: 'Ingrediente',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa un ingrediente';
                      }
                      return null;
                    },
                  ),
                );
              }).toList(),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: _addIngredientField,
              ),

              // Productos
              SizedBox(height: 16),
              Text("Productos"),
              ..._productControllers.map((controller) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                      labelText: 'Producto',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa un producto';
                      }
                      return null;
                    },
                  ),
                );
              }).toList(),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: _addProductField,
              ),

              // Pasos
              SizedBox(height: 16),
              Text("Pasos"),
              ..._stepControllers.map((controller) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                      labelText: 'Paso',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa un paso';
                      }
                      return null;
                    },
                  ),
                );
              }).toList(),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: _addStepField,
              ),
              // Imagen seleccionada
              if (_selectedImage != null)
                Image.file(
                  _selectedImage!,
                  height: 150,
                ),
              SizedBox(height: 16),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: Icon(Icons.add_a_photo),
                  ),
                  SizedBox(width: 30),
                  Text('Subir Foto'),
                ],
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    ingredientes = _ingredientControllers.map((e) => e.text).toList();
                    productos = _productControllers.map((e) => e.text).toList();
                    pasos = _stepControllers.map((e) => e.text).toList();
                    

                    //guardado
                    //this.nombre, this.descripcion,this.ingredientes,this.productos,this.pasos,this.imagen
                    
                    DatabaseHelper.AddRecipe(Receta(nombre,descripcion,ingredientes,productos,pasos,_imageFile!.path));
                    // Lógica para guardar la receta
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Receta guardada con éxito'),
                      ),
                    );
                    _clearControllers();
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
