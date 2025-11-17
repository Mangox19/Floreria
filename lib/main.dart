import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'theme.dart';

// Screens
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/reset_password_screen.dart';
import 'screens/main_screen.dart';
import 'screens/catalog_screen.dart';
import 'screens/map_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Florería Encanto",
      theme: AppTheme.lightTheme,

      initialRoute: "/",

      routes: {
        "/": (context) => const SplashScreen(),
        "/login": (context) => const LoginScreen(),
        "/register": (context) => const RegisterScreen(),
        "/reset": (context) => const ResetPasswordScreen(),
        "/main": (context) => const MainScreen(),
        "/catalog": (context) => const CatalogScreen(),
        "/map": (context) => const MapScreen(),
        "/cart": (context) => const CartScreen(),
        "/profile": (context) => const ProfileScreen(), // NUEVA PANTALLA PERFIL
      },
    );
  }
}
