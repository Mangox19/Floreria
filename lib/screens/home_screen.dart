// si quieres pantalla home real más adelante, aquí placeholder

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Pantalla Home 🌸", style: TextStyle(fontSize: 22)),
      ),
    );
  }
}
