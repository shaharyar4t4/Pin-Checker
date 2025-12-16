import 'package:flutter/material.dart';
import 'package:pinchecker/views/list.dart';
import 'package:pinchecker/views/scan_card_view.dart';
import 'package:pinchecker/views/show_pin_view.dart';
import 'package:provider/provider.dart';
import 'controllers/card_controller.dart';
import 'views/add_card_view.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CardController(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: Colors.teal,
          textTheme: TextTheme(
          bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
          bodyMedium: TextStyle(fontSize: 14, color: Colors.black54),
          titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      home: ViewList(),
    );
  }
}
