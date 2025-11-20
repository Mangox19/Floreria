import 'package:flutter/material.dart';
import '../services/cart_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final referenceController = TextEditingController();
  bool loading = false;

  Future<void> _confirmarPedido() async {
    final items = CartService.instance.items;
    final user = FirebaseAuth.instance.currentUser;

    double total = 0;
    for (var it in items) {
      total += double.tryParse(it["precio"] ?? "0") ?? 0.0;
    }

    if (nameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        addressController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Completa todos los campos obligatorios")),
      );
      return;
    }

    setState(() => loading = true);

    await FirebaseFirestore.instance.collection("pedidos").add({
      "uid": user?.uid,
      "items": items,
      "total": total,
      "fecha": DateTime.now().toString(),
      "nombre": nameController.text,
      "telefono": phoneController.text,
      "direccion": addressController.text,
      "referencia": referenceController.text,
    });

    CartService.instance.clear();
    setState(() => loading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Pedido registrado con éxito 🎉")),
    );

    Navigator.pushReplacementNamed(context, "/orders");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDE2E4),
      appBar: AppBar(
        title: const Text("Dirección de entrega",
            style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFFE5989B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            _input("Nombre completo", nameController),
            const SizedBox(height: 12),
            _input("Teléfono", phoneController),
            const SizedBox(height: 12),
            _input("Dirección", addressController),
            const SizedBox(height: 12),
            _input("Referencia (opcional)", referenceController),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: loading ? null : _confirmarPedido,
                child: loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Confirmar pedido 💗",
                        style: TextStyle(fontSize: 18)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _input(String label, TextEditingController c) {
    return TextField(
      controller: c,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
