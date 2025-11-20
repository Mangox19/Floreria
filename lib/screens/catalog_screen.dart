// lib/screens/catalog_screen.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/cart_service.dart';
import '../widgets/drawer_widget.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  List<Map<String, dynamic>> productos = [];
  List<Map<String, dynamic>> productosFiltrados = [];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    obtenerProductos();
  }

  String convertirEnlaceDrive(String url) {
    final exp = RegExp(r'/d/([a-zA-Z0-9_-]+)');
    final match = exp.firstMatch(url);
    if (match != null) {
      final id = match.group(1);
      return "https://drive.google.com/uc?export=view&id=$id";
    }
    return url;
  }

  Future<void> obtenerProductos() async {
    try {
      final query = await FirebaseFirestore.instance.collection("Catalogo").get();

      final lista = query.docs.map((doc) {
        final data = doc.data();
        return {
          "id": doc.id,
          "descripcion": data.containsKey("descripcion") ? data["descripcion"] : "Sin descripción",
          "precio": data.containsKey("precio") ? data["precio"].toString() : "0",
          "imagen": data.containsKey("imagen") ? convertirEnlaceDrive(data["imagen"]) : "",
        };
      }).toList();

      setState(() {
        productos = lista;
        productosFiltrados = lista;
      });

    } catch (e) {
      print("❌ Error obteniendo productos: $e");
    }
  }

  void filtrarProductos(String query) {
    final resultado = productos.where((item) {
      final texto = query.toLowerCase();
      return item["descripcion"].toLowerCase().contains(texto) ||
             item["precio"].toLowerCase().contains(texto);
    }).toList();

    setState(() => productosFiltrados = resultado);
  }

  @override
  Widget build(BuildContext context) {
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

      body: Column(
        children: [
          // 🔍 BUSCADOR
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: _searchController,
              onChanged: filtrarProductos,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.pinkAccent),
                hintText: "Buscar flores...",
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: Colors.pinkAccent, width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: Colors.pinkAccent),
                ),
              ),
            ),
          ),

          Expanded(
            child: productosFiltrados.isEmpty
                ? const Center(
                    child: Text(
                      "No se encontraron resultados 💐",
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 350,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: productosFiltrados.length,
                    itemBuilder: (context, i) {
                      final item = productosFiltrados[i];

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
                                child: Image.network(
                                  item["imagen"],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  errorBuilder: (_, __, ___) =>
                                      const Icon(Icons.broken_image, size: 60, color: Colors.grey),
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(item["descripcion"],
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center),
                            const SizedBox(height: 4),
                            Text("S/ ${item["precio"]}",
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.pinkAccent,
                                )),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: 140,
                              height: 42,
                              child: ElevatedButton.icon(
                                icon: const Icon(Icons.add_shopping_cart, size: 18),
                                label: const Text("Agregar"),
                                onPressed: () {
                                  CartService.instance.addItem({
                                    "descripcion": item["descripcion"],
                                    "precio": item["precio"],
                                  });

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("${item["descripcion"]} agregado 🛒"),
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
          ),
        ],
      ),
    );
  }
}
