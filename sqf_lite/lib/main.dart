import 'package:flutter/material.dart';
import 'package:sqf_lite/dogs_DB_app/dog_db_view.dart';
import 'package:sqf_lite/todo_DB_app/todo_db_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const TodoPage(title: 'SQFLITE'),
      //home: const DogPage(title: 'SQFLITE'),
    );
  }
}
