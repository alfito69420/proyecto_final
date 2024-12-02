import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapLocation extends StatefulWidget {
  const MapLocation({super.key});

  @override
  State<MapLocation> createState() => MapLocationState();
}

class MapLocationState extends State<MapLocation> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kSanctuaryOverview = CameraPosition(
    target: LatLng(16.9364752, -96.4367293), // Coordenadas exactas
    zoom: 12,
  );

  static const CameraPosition _kSanctuaryClose = CameraPosition(
    target: LatLng(16.9364752, -96.4367293), // Coordenadas exactas
    bearing: 192.8334901395799,
    tilt: 59.440717697143555,
    zoom: 17,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ubicación del Santuario'),
        backgroundColor: Colors.green[700],
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kSanctuaryOverview,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {
          Marker(
            markerId: MarkerId('sanctuary'),
            position: LatLng(16.9364752, -96.4367293), // Coordenadas exactas
            infoWindow: InfoWindow(
              title: 'Santuario Jaguar Yaguar Xoo',
              snippet: 'Hogar de jaguares rescatados',
            ),
          ),
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToSanctuary,
        label: const Text('Ver de cerca'),
        icon: const Icon(Icons.visibility),
        backgroundColor: Colors.orange[800],
      ),
    );
  }

  Future<void> _goToSanctuary() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kSanctuaryClose));
  }
}