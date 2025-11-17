import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/drawer_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = "";
  String email = "";
  String fecha = "";

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final doc = await FirebaseFirestore.instance
        .collection("usuarios")
        .doc(user.uid)
        .get();

    setState(() {
      email = user.email ?? "";
      name = doc["nombre"] ?? "";
      fecha = doc["fechaRegistro"] != null
          ? doc["fechaRegistro"].toDate().toString().substring(0, 10)
          : "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      backgroundColor: const Color(0xFFFDE2E4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE5989B),
        title: const Text("Mi Perfil", style: TextStyle(color: Colors.white)),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),

              // FOTO DE PERFIL
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.pinkAccent.shade200,
                child: const Icon(Icons.person, size: 65, color: Colors.white),
              ),

              const SizedBox(height: 14),

              // NOMBRE
              Text(
                name,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              // CORREO
              Text(
                email,
                style: const TextStyle(fontSize: 18, color: Colors.black54),
              ),

              const SizedBox(height: 24),

              // TARJETA DE DATOS
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Información de la cuenta",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        const Icon(Icons.person),
                        const SizedBox(width: 10),
                        Text("Nombre: $name", style: const TextStyle(fontSize: 18))
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.email),
                        const SizedBox(width: 10),
                        Text("Correo: $email",
                            style: const TextStyle(fontSize: 18))
                      ],
                    ),
                    const SizedBox(height: 10),
                    if (fecha.isNotEmpty)
                      Row(
                        children: [
                          const Icon(Icons.calendar_today),
                          const SizedBox(width: 10),
                          Text("Registrado: $fecha",
                              style: const TextStyle(fontSize: 18))
                        ],
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // BOTÓN EDITAR
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.edit, size: 20),
                  label: const Text("Editar perfil"),
                  onPressed: () {},
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
