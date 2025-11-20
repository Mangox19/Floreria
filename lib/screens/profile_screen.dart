// lib/screens/profile_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/drawer_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String nombre = "";
  String usuario = "";
  String correo = "";
  String foto = "";
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final snap = await FirebaseFirestore.instance
        .collection("usuarios")
        .doc(user.uid)
        .get();

    if (snap.exists) {
      setState(() {
        nombre = snap["nombre"] ?? "Sin nombre";
        usuario = snap["usuario"] ?? "usuario";
        correo = snap["email"] ?? user.email!;
        foto = snap["foto"] ?? "";
      });
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
        foto = picked.path;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Foto cargada temporalmente 📸\n(falta enviar a Firebase Storage)")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      backgroundColor: const Color(0xFFFDE2E4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE5989B),
        title: const Text("Mi Perfil 🌸", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 15),

            // FOTO + BOTÓN EDITAR
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.pink.shade200,
                    backgroundImage: foto.isNotEmpty ? FileImage(File(foto)) : null,
                    child: foto.isEmpty
                        ? const Icon(Icons.person, size: 80, color: Colors.white)
                        : null,
                  ),
                  Container(
                    height: 42,
                    width: 42,
                    decoration: BoxDecoration(
                      color: Colors.pinkAccent,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.camera_alt, size: 20, color: Colors.white),
                      onPressed: _pickImage,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // DATOS
            Text(nombre, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text("@$usuario", style: const TextStyle(fontSize: 18, color: Colors.black54)),
            const SizedBox(height: 5),
            Text(correo, style: const TextStyle(fontSize: 16, color: Colors.black54)),

            const SizedBox(height: 30),
            const Divider(thickness: 1),

            ListTile(
              leading: const Icon(Icons.edit, color: Colors.pinkAccent),
              title: const Text("Editar información"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => Navigator.pushNamed(context, "/editProfile"),
            ),
            ListTile(
              leading: const Icon(Icons.lock_outline, color: Colors.pinkAccent),
              title: const Text("Cambiar contraseña"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => Navigator.pushNamed(context, "/reset"),
            ),
            ListTile(
              leading: const Icon(Icons.receipt_long, color: Colors.pinkAccent),
              title: const Text("Mis pedidos"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => Navigator.pushNamed(context, "/orders"),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.logout),
                label: const Text("Cerrar sesión", style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  if (context.mounted) {
                    Navigator.pushReplacementNamed(context, "/login");
                  }
                },
              ),
            ),

            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
