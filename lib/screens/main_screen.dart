import 'package:flutter/material.dart';
import '../widgets/drawer_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PageController _controller = PageController();
  int _pageIndex = 0;

  final List<Map<String, String>> banners = [
    {"img": "assets/rosas.jpg", "texto": "Las flores son poemas escritos por la naturaleza 🌹"},
    {"img": "assets/tulipanes.jpg", "texto": "Regalar flores es decir sin palabras lo que siente el corazón 💖"},
    {"img": "assets/lirios.jpg", "texto": "Siempre hay una razón para hacer sonreír a alguien 🌸"},
    {"img": "assets/girasol.jpg", "texto": "Haz que cada día florezca ✨"},
  ];

  final List<Map<String, String>> bannersAbajo = [
    {"img": "assets/rosas.jpg", "texto": "El amor florece en los detalles 🌷"},
    {"img": "assets/tulipanes.jpg", "texto": "Un detalle puede cambiar cualquier día 💗"},
    {"img": "assets/lirios.jpg", "texto": "Flores para cada emoción que no puedes explicar 💕"},
    {"img": "assets/girasol.jpg", "texto": "Brilla como un girasol buscando siempre el sol 🌻"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      backgroundColor: const Color(0xFFFDE2E4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE5989B),
        title: const Text("Florería Encanto 🌸", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),

            // BANNER PRINCIPAL
            SizedBox(
              height: 260,
              child: PageView.builder(
                controller: _controller,
                itemCount: banners.length,
                onPageChanged: (index) => setState(() => _pageIndex = index),
                itemBuilder: (context, i) => buildBanner(banners[i]),
              ),
            ),

            const SizedBox(height: 10),
            buildIndicators(),

            const SizedBox(height: 20),

            // BOTÓN IR AL CATALOGO
            ElevatedButton.icon(
              icon: const Icon(Icons.local_florist),
              label: const Text("Ver catálogo de flores"),
              onPressed: () => Navigator.pushNamed(context, "/catalog"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE5989B),
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),

            const SizedBox(height: 28),

            // NUEVA SECCIÓN DE MÁS BANNERS
            const Text(
              "Frases para el corazón 💘",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 16),

            SizedBox(
              height: 260,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: bannersAbajo.length,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, i) => Container(
                  width: 260,
                  margin: const EdgeInsets.only(right: 16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: buildBanner(bannersAbajo[i]),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget buildBanner(Map<String, String> banner) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(banner["img"]!),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.35),
            BlendMode.darken,
          ),
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            banner["texto"]!,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              height: 1.3,
              shadows: [Shadow(blurRadius: 6, color: Colors.black87, offset: Offset(2, 2))],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget buildIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        banners.length,
            (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: _pageIndex == index ? 14 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: _pageIndex == index ? Colors.pinkAccent : Colors.grey,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
