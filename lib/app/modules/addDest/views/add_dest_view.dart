import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project_flutter/controller/Databese_Service.dart';





class AddDestView extends StatefulWidget {
  @override
  _AddDestViewState createState() => _AddDestViewState();
}

class _AddDestViewState extends State<AddDestView> {
  final DatabaseService _databaseService =
      DatabaseService(); // Instance of DatabaseService

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

  bool _validateAmenities() {
    for (var controller in _amenitiesControllers) {
      if (controller.text.isEmpty) return false;
    }
    return true;
  }

  Future<void> _submitData() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_validateAmenities()) {
        try {
          double rating = double.parse(_ratingController.text);
          double price = double.parse(_priceController.text);

          await _databaseService.addDestination(
            name: _sumbaIslandController.text,
            location: _locationController.text,
            rating: double.parse(_ratingController.text),
            amenities: _amenitiesControllers.map((c) => c.text).toList(),
            price: double.parse(_priceController.text),
            selfCheckIn: _selfCheckInController.text,
            cleanAccommodation: _cleanAccommodationController.text,
          );

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Data berhasil disimpan ke Firebase Firestore!')));
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Gagal menyimpan data: $e')));
        }
        Get.back();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Harap isi minimal 5 fasilitas')));
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
                        color: Colors.white, // Set color to white
                        width: 64.0, // Adjust width for a larger size
                        height: 64.0, // Adjust height for a larger size
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
