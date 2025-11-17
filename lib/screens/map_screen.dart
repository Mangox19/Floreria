// lib/screens/map_screen.dart
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../widgets/drawer_widget.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;

  static const LatLng floreriaPos = LatLng(-12.0656, -75.2042);

  final Set<Marker> _markers = {
    const Marker(
      markerId: MarkerId("floreria"),
      position: floreriaPos,
      infoWindow: InfoWindow(title: "Florería Encanto 🌸"),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      backgroundColor: const Color(0xFFFDE2E4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE5989B),
        title: const Text("Mapa de ubicación", style: TextStyle(color: Colors.white)),
      ),

      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: const CameraPosition(
          target: floreriaPos,
          zoom: 16,
        ),
        markers: _markers,
        onMapCreated: (controller) => _controller = controller,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: false,
      ),
    );
  }
}
