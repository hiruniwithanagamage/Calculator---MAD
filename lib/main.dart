// Hiruni Withanagamge
// IM/2021/082
// lib/main.dart
import 'package:flutter/material.dart';
import 'calculator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}
// Hiruni Withanagamge
// IM/2021/082
