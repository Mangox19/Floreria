import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDE2E4),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 90, color: Colors.pinkAccent),
            const SizedBox(height: 20),

            const Text(
              "Registro Completo 🎉",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 10),
            const Text(
              "Gracias por unirte a Florería Encanto 🌸",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () => Navigator.pushReplacementNamed(context, "/login"),
                child: const Text("Ir a Iniciar Sesión"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
