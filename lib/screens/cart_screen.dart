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
    double total = items.fold(0, (p, e) => p + (double.tryParse(e["precio"] ?? "0") ?? 0));

    return Scaffold(
      drawer: const AppDrawer(),
      backgroundColor: const Color(0xFFFDE2E4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE5989B),
        title: const Text("Carrito", style: TextStyle(color: Colors.white)),
      ),

      body: Column(
        children: [
          Expanded(
            child: items.isEmpty
                ? const Center(child: Text("Carrito vacío 🌸"))
                : ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, i) {
                      return ListTile(
                        title: Text(items[i]["nombre"] ?? ""),
                        subtitle: Text("S/ ${items[i]["precio"]}"),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.pink),
                          onPressed: () => setState(() => CartService.instance.removeAt(i)),
                        ),
                      );
                    },
                  ),
          ),

          Container(
            padding: const EdgeInsets.all(18),
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                Text("Total: S/ ${total.toStringAsFixed(2)}", style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
                    onPressed: items.isEmpty
                        ? null
                        : () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Pedido realizado con éxito 🌸")),
                            );
                            CartService.instance.clear();
                            setState(() {});
                          },
                    child: const Text("Pagar 💳", style: TextStyle(fontSize: 18)),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
