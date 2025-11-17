import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFFDE2E4),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFFE5989B)),
            child: Center(
              child: Text(
                "Florería Encanto 🌸",
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
          ),

          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Inicio"),
            onTap: () => Navigator.pushReplacementNamed(context, "/main"),
          ),
          ListTile(
            leading: const Icon(Icons.local_florist),
            title: const Text("Catálogo"),
            onTap: () => Navigator.pushReplacementNamed(context, "/catalog"),
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text("Carrito"),
            onTap: () => Navigator.pushReplacementNamed(context, "/cart"),
          ),
          ListTile(
            leading: const Icon(Icons.map),
            title: const Text("Mapa"),
            onTap: () => Navigator.pushReplacementNamed(context, "/map"),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Perfil"),
            onTap: () => Navigator.pushReplacementNamed(context, "/profile"),
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Cerrar sesión"),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, "/login");
            },
          ),
        ],
      ),
    );
  }
}
