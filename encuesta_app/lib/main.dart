import 'package:flutter/material.dart';
import 'screens/encuesta_screen.dart';

/// PROYECTO INDEPENDIENTE · Clase 2 · Encuesta de Satisfacción
///
/// Ejecutar con:  flutter run   (dentro de la carpeta encuesta_app)
void main() {
  runApp(const EncuestaApp());
}

class EncuestaApp extends StatelessWidget {
  const EncuestaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Encuesta de Feedback',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const EncuestaScreen(),
    );
  }
}
