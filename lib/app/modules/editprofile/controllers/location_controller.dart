import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationController extends ChangeNotifier {
  Position? _currentPosition;
  String _locationMessage = "Mencari Lokasi...";
  bool _loading = false;

  String get locationMessage => _locationMessage;
  bool get loading => _loading;

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    _setLoading(true);
    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        throw Exception('Layanan lokasi tidak aktif');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Izin lokasi ditolak');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        throw Exception('Izin lokasi ditolak selamanya');
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
      _currentPosition = position;
      await _getAddressFromCoordinates(position.latitude, position.longitude);
      _setLoading(false);
    } catch (e) {
      _setLoading(false);
      _locationMessage = 'Gagal mendapatkan lokasi: ${e.toString()}';
      notifyListeners();
    }
  }

  Future<void> _getAddressFromCoordinates(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        _locationMessage = '${place.locality}, ${place.administrativeArea}';
      } else {
        _locationMessage = 'Alamat tidak ditemukan';
      }
      notifyListeners();
    } catch (e) {
      _locationMessage = 'Gagal mendapatkan alamat: ${e.toString()}';
      notifyListeners();
    }
  }

  void _setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  void openGoogleMaps() {
    if (_currentPosition != null) {
      final url =
          'https://www.google.com/maps?q=${_currentPosition!.latitude},${_currentPosition!.longitude}';
      _launchURL(url);
    } else {
      _locationMessage = 'Koordinat belum tersedia. Cari lokasi terlebih dahulu.';
      notifyListeners();
    }
  }

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}
