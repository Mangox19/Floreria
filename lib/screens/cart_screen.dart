// lib/screens/cart_screen.dart

import 'package:flutter/material.dart';
import '../services/cart_service.dart';
import '../widgets/drawer_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final items = CartService.instance.items;

    return Scaffold(
      drawer: const AppDrawer(),  // 🔥 Drawer agregado
      backgroundColor: const Color(0xFFFDE2E4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE5989B),
        title: const Text("Carrito 🛒", style: TextStyle(color: Colors.white)),
      ),

      body: items.isEmpty
          ? const Center(
              child: Text(
                "El carrito está vacío 🌸",
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              itemBuilder: (context, i) {
                final p = items[i];
                return Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    title: Text(
                      p["nombre"] ?? "",
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    subtitle: Text("S/ ${p["precio"]}",
                        style: const TextStyle(color: Colors.pinkAccent, fontSize: 15)),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.pink),
                      onPressed: () {
                        setState(() => CartService.instance.removeAt(i));
                      },
                    ),
                  ),
                );
              },
            ),

      bottomNavigationBar: items.isEmpty
          ? null
          : Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, -2),
                  )
                ],
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Pedido registrado correctamente 🌸"),
                      duration: Duration(seconds: 3),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  CartService.instance.clear();
                  setState(() {});
                },
                child: const Text("Pagar Carrito"),
              ),
            ),
    );
  }
}
