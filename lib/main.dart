import 'package:flutter/material.dart';
import 'pages/my_home_page.dart'; 

import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:cafemixes/utils/DatabaseHelper.dart';

void main() async
{
  //iniciar y/o abrir la base de datos
  WidgetsFlutterBinding.ensureInitialized();

  DatabaseHelper.InitDatabase();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CafeMixes',
      home: const MyHomePage(),
      color: const Color.fromARGB(221, 255, 255, 255),
    );
  }
}
