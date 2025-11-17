import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  bool loading = false;

  Future<void> _login() async {
    setState(() => loading = true);

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
      // 🌸 VA A MAIN DESPUÉS DE INICIAR SESIÓN
      Navigator.pushReplacementNamed(context, "/main");
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: ${e.message}")));
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDE2E4),

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Florería Encanto",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.pinkAccent,
              ),
            ),

            const SizedBox(height: 10),
            const Icon(Icons.local_florist, size: 85, color: Colors.pinkAccent),

            const SizedBox(height: 30),

            TextField(
              controller: email,
              decoration: const InputDecoration(labelText: "Correo"),
            ),

            const SizedBox(height: 14),

            TextField(
              controller: password,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Contraseña"),
            ),

            const SizedBox(height: 22),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: loading ? null : _login,
                child: loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Iniciar Sesión", style: TextStyle(fontSize: 18)),
              ),
            ),

            const SizedBox(height: 12),

            TextButton(
              onPressed: () => Navigator.pushNamed(context, "/reset"),
              child: const Text(
                "¿Olvidaste tu contraseña?",
                style: TextStyle(color: Colors.pink, fontSize: 15),
              ),
            ),

            TextButton(
              onPressed: () => Navigator.pushNamed(context, "/register"),
              child: const Text(
                "Crear cuenta nueva",
                style: TextStyle(color: Colors.pink, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
