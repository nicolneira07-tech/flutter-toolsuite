import 'package:flutter/material.dart';
import 'screens/calculadora_screen.dart';

/// PROYECTO INDEPENDIENTE · Clase 2 · Calculadora Pro
///
/// Ejecutar con:  flutter run   (dentro de la carpeta calculadora_app)
void main() {
  runApp(const CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  const CalculadoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora Pro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const CalculadoraScreen(),
    );
  }
}
