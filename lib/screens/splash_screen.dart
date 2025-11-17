import 'dart:async';
import 'package:flutter/material.dart';
import '../theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Siempre abrir login primero (flujo profesional)
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, "/login");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.pastelPink,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // LOGO
            SizedBox(
              width: 180,
              height: 180,
              child: Image.asset(
                "assets/logo.png",
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 16),

            // TÍTULO FLORERÍA
            const Text(
              "Florería Encanto",
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE5989B),
              ),
            ),

            const SizedBox(height: 20),

            const CircularProgressIndicator(
              color: Color(0xFFE5989B),
            ),

            const SizedBox(height: 14),

            const Text(
              "Cargando...",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
