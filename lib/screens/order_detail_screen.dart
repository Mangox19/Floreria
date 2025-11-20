import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DocumentSnapshot pedido =
        ModalRoute.of(context)!.settings.arguments as DocumentSnapshot;

    final data = pedido.data() as Map<String, dynamic>;

    return Scaffold(
      backgroundColor: const Color(0xFFFDE2E4),
      appBar: AppBar(
        title: const Text("Detalle del pedido", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFFE5989B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Pedido: #${pedido.id.substring(0, 6)}",
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            Text("Total pagado: S/ ${data["total"]}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),

            Text("Dirección: ${data["direccion"]}",
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),

            Text("Fecha: ${data["fecha"]}",
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 18),

            const Text("Productos:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),

            Expanded(
              child: ListView.builder(
                itemCount: data["items"].length,
                itemBuilder: (context, i) {
                  final prod = data["items"][i];
                  return ListTile(
                    leading: const Icon(Icons.local_florist),
                    title: Text(prod["nombre"]),
                    trailing: Text("S/ ${prod["precio"]}"),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.map),
                label: const Text("Seguimiento del pedido"),
                onPressed: () => Navigator.pushNamed(context, "/map"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
