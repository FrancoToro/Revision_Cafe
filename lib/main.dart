import 'package:flutter/material.dart';
import 'pages/my_home_page.dart'; 

import 'dart:async';
import 'package:cafemixes/utils/colors.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:cafemixes/utils/DatabaseHelper.dart';

void main() async
{

  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.InitDatabase();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  

  @override
  Widget build(BuildContext context) {
     MaterialColor colorcafe = Colors.Cafe;
    return MaterialApp(
      title: 'CafeMixes',
      theme: ThemeData(
        primarySwatch: Colors.Cafe,
         scaffoldBackgroundColor: CafeColors.Cafe.shade50,
        visualDensity: VisualDensity.adaptivePlatformDensity,

      ),
      home: const MyHomePage(),

    );
  }
}
