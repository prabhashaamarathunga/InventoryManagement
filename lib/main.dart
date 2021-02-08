import 'package:flutter/material.dart';
import 'package:inven/pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'NoteKeeper',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        ),
      home: Home(),
    );
  }
}