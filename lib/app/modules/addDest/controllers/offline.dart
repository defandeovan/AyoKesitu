import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_flutter/app/data/Databese_Service.dart';

class OfflineDataSyncService {
  final GetStorage _storage = GetStorage();
  final DatabaseService _databaseService = DatabaseService();
  final Connectivity _connectivity = Connectivity();


  static const String _offlineDestinationsKey = 'offline_destinations';

 
  Future<void> saveOfflineDestination(
      Map<String, dynamic> destinationData) async {
  
    List<dynamic> offlineDestinations =
        _storage.read(_offlineDestinationsKey) ?? [];


    offlineDestinations.add(destinationData);

 
    await _storage.write(_offlineDestinationsKey, offlineDestinations);
  }

  Future<void> syncOfflineData(BuildContext context) async {
 
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Data sedang disinkronkan ke Firebase Firestore!')),
  );

  
  List<dynamic> offlineDestinations =
      _storage.read(_offlineDestinationsKey) ?? [];

  if (offlineDestinations.isNotEmpty) {
    List<dynamic> failedDestinations = [];

    for (var destination in offlineDestinations) {
      try {
        
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
       
        print('Failed to sync destination: $e');
        failedDestinations.add(destination);
      }
    }

 
    await _storage.write(_offlineDestinationsKey, failedDestinations);
  }
}



  void startConnectivityListener(BuildContext context) {
    _connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> results) async {
      if (results.isNotEmpty && results.first != ConnectivityResult.none) {
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Menghubungkan Kembali')),
        );

        await syncOfflineData(context);
      }
    });
  }
}
