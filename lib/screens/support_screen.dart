import 'package:flutter/material.dart';
import '../widgets/drawer_widget.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      backgroundColor: const Color(0xFFFDE2E4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE5989B),
        title: const Text(
          "Servicio al Cliente 💬",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              // LOGO GRANDE
              ClipRRect(
                borderRadius: BorderRadius.circular(80),
                child: Image.asset(
                  "assets/logo.png",
                  width: 160,
                  height: 160,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "¿Necesitas ayuda? 🌸",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.pinkAccent,
                ),
              ),

              const SizedBox(height: 12),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Estamos aquí para ayudarte con tus compras, entregas y consultas.\n"
                  "Contáctanos por cualquiera de nuestros medios:",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "📩 soporte@floreriaencanto.com\n\n📞 +51 987 654 321\n\n📍 Huancayo - Perú",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),

              const SizedBox(height: 25),

              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                onPressed: () => Navigator.pushReplacementNamed(context, "/main"),
                icon: const Icon(Icons.home),
                label: const Text(
                  "Volver al inicio",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
