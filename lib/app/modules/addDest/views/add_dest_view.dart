import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:project_flutter/app/data/Databese_Service.dart';
import 'package:get_storage/get_storage.dart';

import 'package:project_flutter/app/modules/addDest/controllers/offline.dart';

class AddDestView extends StatefulWidget {
  @override
  _AddDestViewState createState() => _AddDestViewState();
}

class _AddDestViewState extends State<AddDestView> {
  final Connectivity _connectivity = Connectivity();
  final DatabaseService _databaseService = DatabaseService();
  final GetStorage _getStorage = GetStorage();

  final TextEditingController _sumbaIslandController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  final List<TextEditingController> _amenitiesControllers =
      List.generate(5, (_) => TextEditingController());
  final TextEditingController _selfCheckInController = TextEditingController();
  final TextEditingController _cleanAccommodationController =
      TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final OfflineDataSyncService _offlineDataSyncService =
      OfflineDataSyncService();
  bool _isLoading = false;
 String? imageUrl;
  bool _validateAmenities() {
    for (var controller in _amenitiesControllers) {
      if (controller.text.isEmpty) return false;
    }
    return true;
  }

  Future<void> _saveToFirebase() async {
    try {
      await _databaseService.addDestination(
        name: _sumbaIslandController.text,
        location: _locationController.text,
        rating: double.parse(_ratingController.text),
        amenities: _amenitiesControllers.map((c) => c.text).toList(),
        price: double.parse(_priceController.text),
        selfCheckIn: _selfCheckInController.text,
        cleanAccommodation: _cleanAccommodationController.text,
            img: imageUrl ?? '',
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Data berhasil disimpan ke Firebase Firestore!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan data: $e')),
      );
    }
  }

  Future<void> _saveToGetStorage() async {
    try {
      await _getStorage.write('destination', {
        'name': _sumbaIslandController.text,
        'location': _locationController.text,
        'rating': _ratingController.text,
        'amenities': _amenitiesControllers.map((c) => c.text).toList(),
        'price': _priceController.text,
        'selfCheckIn': _selfCheckInController.text,
        'cleanAccommodation': _cleanAccommodationController.text,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data berhasil disimpan ke GetStorage!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan data: $e')),
      );
    }
  }

  void _showSaveDialog() async {
    List<ConnectivityResult> connectivityResult =
        await _connectivity.checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      await _saveToGetStorage();
    } else {
      await _saveToFirebase();
    }
  }

  Future<void> _uploadStoredData() async {
    final storedData = _getStorage.read('destination');
    if (storedData != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Data sedang diupload ke Firebase Firestore!')),
      );

      try {
        await _databaseService.addDestination(
            name: storedData['name'],
            location: storedData['location'],
            rating: double.parse(storedData['rating']),
            amenities: List<String>.from(storedData['amenities']),
            price: double.parse(storedData['price']),
            selfCheckIn: storedData['selfCheckIn'],
            cleanAccommodation: storedData['cleanAccommodation'],
            img: storedData['img']);
        await _getStorage.remove('destination');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Data berhasil diupload ke Firebase Firestore!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal mengupload data: $e')),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult.contains(ConnectivityResult.none)) {
      } else {
        _uploadStoredData();
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(
        //       content: Text('Data sedang diupload ke Firebase Firestore!')),
        // );
      }
    });

    _offlineDataSyncService.startConnectivityListener(context);
  }

  Future<void> _processData(String storageOption) async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 15));

    if (storageOption == 'firebase') {
      await _saveToFirebase();
    } else {
      await _saveToGetStorage();
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _submitData() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_validateAmenities()) {
        setState(() {
          _isLoading = true;
        });

        // Prepare destination data
        Map<String, dynamic> destinationData = {
          'name': _sumbaIslandController.text,
          'location': _locationController.text,
          'rating': _ratingController.text,
          'amenities': _amenitiesControllers.map((c) => c.text).toList(),
          'price': _priceController.text,
          'selfCheckIn': _selfCheckInController.text,
          'cleanAccommodation': _cleanAccommodationController.text,
        };

        try {
          // Check connectivity
          var connectivityResult = await _connectivity.checkConnectivity();

          if (connectivityResult.contains(ConnectivityResult.none)) {
            // No internet - save to offline storage
            await _offlineDataSyncService
                .saveOfflineDestination(destinationData);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Data saved locally. Will sync when online.')),
            );
          } else {
            // Internet available - upload directly to Firebase
            await _databaseService.addDestination(
              name: destinationData['name'],
              location: destinationData['location'],
              rating: double.parse(destinationData['rating']),
              amenities: List<String>.from(destinationData['amenities']),
              price: double.parse(destinationData['price']),
              selfCheckIn: destinationData['selfCheckIn'],
              cleanAccommodation: destinationData['cleanAccommodation'],
              img: destinationData['img'],
            );

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Data successfully uploaded!')),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error saving data: $e')),
          );
        } finally {
          setState(() {
            _isLoading = false;
          });
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill at least 5 amenities')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  Container(
                    height: 400,
                    decoration: BoxDecoration(color: Colors.grey),
                  ),
                  Positioned(
                    top: 200,
                    left: 0,
                    right: 0,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: SvgPicture.asset(
                        'assets/img/camera.svg',
                        color: Colors.white,
                        width: 64.0,
                        height: 64.0,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _sumbaIslandController,
                      decoration: InputDecoration(
                        labelText: 'Destination',
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Image.asset('assets/img/Map Pin.png'),
                        SizedBox(width: 4),
                        Expanded(
                          child: TextField(
                            controller: _locationController,
                            decoration: InputDecoration(
                              hintText: 'Location',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        Expanded(
                          child: TextField(
                            controller: _ratingController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Rating (e.g. 4.9)',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: DottedLine(
                        dashColor: Colors.grey,
                        dashLength: 4.0,
                        dashGapLength: 4.0,
                        lineThickness: 1.0,
                      ),
                    ),
                    Text(
                      'Amenities (min 5)',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    for (int i = 0; i < 5; i++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: TextField(
                          controller: _amenitiesControllers[i],
                          decoration: InputDecoration(
                            hintText: 'Enter amenity ${i + 1}',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.all(10),
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: DottedLine(
                        dashColor: Colors.grey,
                        dashLength: 4.0,
                        dashGapLength: 4.0,
                        lineThickness: 1.0,
                      ),
                    ),
                    TextField(
                      controller: _selfCheckInController,
                      decoration: InputDecoration(
                        labelText: 'Self Check-in Info',
                      ),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: _cleanAccommodationController,
                      decoration: InputDecoration(
                        labelText: 'Clean Accommodation Info',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: DottedLine(
                        dashColor: Colors.grey,
                        dashLength: 4.0,
                        dashGapLength: 4.0,
                        lineThickness: 1.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Color(0xFFF0DBFFEC),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Enter Price:',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            TextField(
                              controller: _priceController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: 'Enter price in USD',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.all(10),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _submitData,
                      child: Text('Submit'),
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                        backgroundColor: Color(0xFF00A550),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    if (_isLoading)
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
