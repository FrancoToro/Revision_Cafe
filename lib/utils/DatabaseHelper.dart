import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:cafemixes/model/Receta.dart';

class DatabaseHelper 
{
    static late Future<Database> database;

    static void InitDatabase() async
    {
        database = openDatabase(
            join(await getDatabasesPath(),"coffee_db"),
            onCreate: (db, version) {
                return db.execute("CREATE TABLE recipes(id INTEGER PRIMARY KEY AUTOINCREMENT, recipe STRING)");
                }, version: 1,
            );
    }

    static void AddRecipe(Receta r)
    {

    }
}