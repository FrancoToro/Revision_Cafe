import 'dart:async';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart' ;

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:cafemixes/model/Receta.dart';

class DatabaseHelper 
{ 
    static late final Database database;

    static _onCreate(Database db, int version) async
    {
      await db.execute("CREATE TABLE recipes(id INTEGER PRIMARY KEY, recipe STRING, fav INT)");        
      
      for (int i = 1; i<5; i++)
      {
        String n1 = await readAsset('assets/recipe$i.json');
        Map<String, Object?> data =
        {
          'id': i,
          'recipe': n1,
          'fav': 1
        };

        await db.insert('recipes',data, conflictAlgorithm: ConflictAlgorithm.replace);

        print("insertado $i : $n1");
      }
    }

    static void InitDatabase() async
    {
      
        database = await openDatabase(
            join(await getDatabasesPath(),"coffee_db"),
            onCreate: _onCreate,
            version: 1,
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

    static Future<void> updateRecipe(Receta r) async
    {
      final db = await database;
      Map<String, Object?> data =
      {
        'id': r.id,
        'recipe': jsonEncode(r.toJson()),
        'fav': r.favorita ? 1:0
      };
      await db.update('recipes', data, where: 'id = ?', whereArgs: [r.id]);
    }

    static Future<List<Receta>> GetRecipes() async {
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

    static Future<List<Receta>> GetFavoriteRecipes() async {
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

    static Future<Receta> GetRecipeById(int id) async
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
          'recipe': recipe as String,
          'fav': fav as bool
        } in dbMaps)
        Receta.fromJson(jsonDecode(recipe), f: fav)];

        return list.first;
      }

      throw new FormatException("BASE DE DATOS VACIA");
    }

    static Future<String> readAsset(String n) async
    {
      return await rootBundle.loadString(n);
    }
}