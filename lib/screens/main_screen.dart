import 'package:flutter/material.dart';
import '../widgets/drawer_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE5989B),
        title: const Text("Inicio", style: TextStyle(color: Colors.white)),
      ),
      body: const Center(
        child: Text(
          "Bienvenido a Florería Encanto 🌸",
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
