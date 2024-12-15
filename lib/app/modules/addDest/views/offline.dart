import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_flutter/app/data/Databese_Service.dart';

class OfflineDataSyncService {
  final GetStorage _storage = GetStorage();
  final DatabaseService _databaseService = DatabaseService();
  final Connectivity _connectivity = Connectivity();

  // Key for storing offline destinations
  static const String _offlineDestinationsKey = 'offline_destinations';

  // Save destination data when offline
  Future<void> saveOfflineDestination(
      Map<String, dynamic> destinationData) async {
    // Retrieve existing offline destinations
    List<dynamic> offlineDestinations =
        _storage.read(_offlineDestinationsKey) ?? [];

    // Add new destination
    offlineDestinations.add(destinationData);

    // Save updated list back to storage
    await _storage.write(_offlineDestinationsKey, offlineDestinations);
  }

  // Method to sync offline data when internet is available
  Future<void> syncOfflineData(BuildContext context) async {
  // Tampilkan notifikasi bahwa data sedang disinkronkan
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Data sedang disinkronkan ke Firebase Firestore!')),
  );

  // Read offline destinations
  List<dynamic> offlineDestinations =
      _storage.read(_offlineDestinationsKey) ?? [];

  if (offlineDestinations.isNotEmpty) {
    List<dynamic> failedDestinations = [];

    for (var destination in offlineDestinations) {
      try {
        // Upload to Firebase
        await _databaseService.addDestination(
          name: destination['name'],
          location: destination['location'],
          rating: double.parse(destination['rating']),
          amenities: List<String>.from(destination['amenities']),
          price: double.parse(destination['price']),
          selfCheckIn: destination['selfCheckIn'],
          cleanAccommodation: destination['cleanAccommodation'],
        );
      } catch (e) {
        // If upload fails, add to failed destinations
        print('Failed to sync destination: $e');
        failedDestinations.add(destination);
      }
    }

    // Update storage with any failed destinations
    await _storage.write(_offlineDestinationsKey, failedDestinations);
  }
}


  // Listen for connectivity changes and attempt to sync
  void startConnectivityListener(BuildContext context) {
    _connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> results) async {
      if (results.isNotEmpty && results.first != ConnectivityResult.none) {
        // Tampilkan notifikasi bahwa data sedang diupload
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('')),
        );

        await syncOfflineData(context);
      }
    });
  }
}
