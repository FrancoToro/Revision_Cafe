import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper 
{
    static final database;

    static void InitDatabase()
    {
        database = openDatabase(
            join(await getDatabasesPath(),"coffee_db"),
            onCreate: (db, version) {
                return db.execute("CREATE TABLE recipes(id INTEGER PRIMARY KEY AUTOINCREMENT, nombre TEXT, descripcion TEXT, ingredientes TEXT, pasos TEXT, favorita INTEGER)");
                }, version: 1,
            );
    }
}