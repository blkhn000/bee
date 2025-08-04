import 'package:flutter/material.dart';
import 'package:spbee/app.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const SpellingBeeApp());
}

class SpellingBeeApp extends StatelessWidget {
  const SpellingBeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Білім бәйгесі',
      theme: ThemeData(
        fontFamily: 'KazakFont', // подключим казахский шрифт позже
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const WelcomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
