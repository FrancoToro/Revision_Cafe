import 'dart:async';
import 'dart:convert';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:cafemixes/model/Receta.dart';

class DatabaseHelper 
{
    static late final Future<Database> database;

    static void InitDatabase() async
    {
        database = openDatabase(
            join(await getDatabasesPath(),"coffee_db"),
            onCreate: (db, version) {
                return db.execute("CREATE TABLE recipes(id INTEGER PRIMARY KEY AUTOINCREMENT, recipe STRING, fav INT)");
                }, version: 1,
            );
    }

    //guardar en base de dato a partir de objeto
    static Future<void> AddRecipe(Receta r) async
    {
      final db = await database;

      Map<String, Object?> data =
      {
        'id': r.id,
        'recipe': jsonEncode(r.toJson()),
        'fav': r.favorita ? 1 : 0
      };

      await db.insert('recipes', data, conflictAlgorithm: ConflictAlgorithm.replace);
    }

    Future<void> updateRecipe(Receta r) async
    {
      final db = await database;
      Map<String, Object?> data =
      {
        'id': r.id,
        'recipe': jsonEncode(r.toJson())
      };
      await db.update('recipes', data, where: 'id = ?', whereArgs: [r.id]);
    }

    Future<List<Receta>> GetRecipes() async {
      final db = await database;

      final List<Map<String, Object?>> dbMaps = await db.query('recipes');

      return [
        for (final {
          'id': id as int,
          'recipe': recipe as String,
          'fav': fav as bool
        } in dbMaps)
        Receta.fromJson(jsonDecode(recipe), f: fav)
      ];
    }

    Future<List<Receta>> GetFavoriteRecipes() async {
      final db = await database;

      final List<Map<String, Object?>> dbMaps = await db.query('recipes',where: 'fav = ?', whereArgs: [1]);

      return [
        for (final {
          'id': id as int,
          'recipe': recipe as String
        } in dbMaps)
        Receta.fromJson(jsonDecode(recipe), f: true)
      ];
    }

    Future<Receta> GetRecipeById(int id) async
    {
      final db = await database;
      final List<Map<String, Object?>> dbMaps = await db.query('recipes',where: 'id = ?', whereArgs: [id]);
      
      if (dbMaps.isNotEmpty)
      {
        //crear lista (si hay mas de una)
        List<Receta> list = 
        [
        for (final {
          'id': id as int,
          'recipe': recipe as String
        } in dbMaps)
        Receta.fromJson(jsonDecode(recipe))];

        return list.first;
      }

      throw new FormatException("BASE DE DATOS VACIA");
    }
}