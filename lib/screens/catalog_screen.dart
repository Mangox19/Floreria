// lib/screens/catalog_screen.dart
import 'package:flutter/material.dart';
import '../services/cart_service.dart';
import '../widgets/drawer_widget.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> productos = [
      {
        "nombre": "Ramo de Rosas",
        "descripcion": "Ramo premium con 12 rosas rojas frescas.",
        "precio": "35",
        "imagen": "assets/rosas.jpg",
      },
      {
        "nombre": "Tulipanes Rosados",
        "descripcion": "Elegante ramo de 10 tulipanes rosados.",
        "precio": "28",
        "imagen": "assets/tulipanes.jpg",
      },
      {
        "nombre": "Lirios Blancos",
        "descripcion": "Ramo de lirios blancos aromáticos.",
        "precio": "25",
        "imagen": "assets/lirios.jpg",
      },
      {
        "nombre": "Girasoles",
        "descripcion": "Brillante ramo de 8 girasoles amarillos.",
        "precio": "22",
        "imagen": "assets/girasol.jpg", // 🔥 corregido nombre de la imagen
      },
    ];

    return Scaffold(
      drawer: const AppDrawer(),
      backgroundColor: const Color(0xFFFDE2E4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE5989B),
        title: const Text("Catálogo de Flores 🌸", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () => Navigator.pushNamed(context, "/cart"),
          ),
        ],
      ),

      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 350,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: productos.length,
        itemBuilder: (context, i) {
          final item = productos[i];

          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.asset(
                      item["imagen"]!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (context, error, stackTrace) =>
                          Container(
                            color: Colors.grey[300],
                            child: const Icon(Icons.broken_image, size: 60, color: Colors.black45),
                          ),
                    ),
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  item["nombre"]!,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    item["descripcion"]!,
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  "S/ ${item["precio"]}",
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.pinkAccent,
                  ),
                ),

                const SizedBox(height: 6),

                SizedBox(
                  width: 140,
                  height: 42,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.add_shopping_cart, size: 18),
                    label: const Text("Agregar"),
                    onPressed: () {
                      CartService.instance.addItem({
                        "nombre": item["nombre"]!,
                        "precio": item["precio"]!,
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("${item["nombre"]} agregado al carrito 🛒"),
                          duration: const Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          );
        },
      ),
    );
  }
}
