import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFFDE2E4),
      child: Column(
        children: [

          // CABECERA CON LOGO
          DrawerHeader(
            decoration: const BoxDecoration(color: Color(0xFFE5989B)),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Image.asset(
                      "assets/logo.png",
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Florería Encanto",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ),

          // OPCIONES DE MENÚ
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
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
                /*ListTile(
                  leading: const Icon(Icons.receipt_long),
                  title: const Text("Mis pedidos"),
                  onTap: () => Navigator.pushReplacementNamed(context, "/orders"),
                ),*/
                ListTile(
                  leading: const Icon(Icons.support_agent),
                  title: const Text("Servicio al cliente"),
                  onTap: () => Navigator.pushReplacementNamed(context, "/support"),
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text("Perfil"),
                  onTap: () => Navigator.pushReplacementNamed(context, "/profile"),
                ),
              ],
            ),
          ),

          // CERRAR SESIÓN ABAJO Y EN ROJO
          Container(
            padding: const EdgeInsets.only(bottom: 20),
            child: ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                "Cerrar sesión",
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, "/login");
              },
            ),
          ),
        ],
      ),
    );
  }
}
