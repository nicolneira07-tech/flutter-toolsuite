import 'package:flutter/material.dart';
import 'screens/menu_screen.dart';

void main() {
  runApp(const MiSuiteApp());
}

class MiSuiteApp extends StatelessWidget {
  const MiSuiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToolSuite App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const MenuScreen(),
    );
  }
}