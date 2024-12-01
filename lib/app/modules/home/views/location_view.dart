import 'dart:ffi';

import 'package:flutter/material.dart';
import '../controllers/location_controller.dart';

class LocationView extends StatefulWidget {
  const LocationView({super.key});

  @override
  State<LocationView> createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  final LocationController _locationController = LocationController();
  String _locationMessage = "Mencari Lokasi...";

  @override
  void initState() {
    super.initState();
    _locationController.addListener(_updateLocationMessage);
    _locationController
        .getCurrentLocation(); // Automatically load location when init
  }

  @override
  void dispose() {
    _locationController.removeListener(_updateLocationMessage);
    super.dispose();
  }

  // Update location message when location controller updates
  void _updateLocationMessage() {
    setState(() {
      _locationMessage = _locationController.locationMessage;
    });
  }

  // Open Google Maps to show location
  void _openGoogleMaps() {
    _locationController.openGoogleMaps();
  }

    @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _openGoogleMaps, // Open Google Maps when tapped
      child: Align(
        alignment: Alignment.centerLeft, // Memastikan widget dimulai dari kiri
        child: Row(
          mainAxisSize: MainAxisSize.min, // Ukuran Row sesuai dengan ukuran konten
          crossAxisAlignment: CrossAxisAlignment.center, // Menjaga gambar dan teks sejajar vertikal
          children: [
              SizedBox(width: 8),
            Image.asset(
              'assets/img/Map Pin.png',
              height: 24, // Sesuaikan ukuran gambar agar sejajar dengan teks
              width: 24,
            ),
           // Jarak antara gambar dan teks
            Text(
              _locationMessage,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),
    );
  }
}
