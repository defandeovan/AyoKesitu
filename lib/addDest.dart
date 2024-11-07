import 'package:flutter/material.dart';
import 'Databese_Service.dart';

class AddDestinationScreen extends StatefulWidget {
  @override
  _AddDestinationScreenState createState() => _AddDestinationScreenState();
}

class _AddDestinationScreenState extends State<AddDestinationScreen> {
  final _formKey = GlobalKey<FormState>();
  final DatabaseService _databaseService = DatabaseService();

  // Controller untuk form input
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  final TextEditingController _amenitiesController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  // Fungsi untuk menyimpan data destinasi
  void _saveDestination() {
    if (_formKey.currentState!.validate()) {
      // Memproses daftar amenities yang diinputkan sebagai teks
      List<String> amenities = _amenitiesController.text.split(',');

      // Menyimpan data ke database
      _databaseService.addDestination(
        name: _nameController.text,
        location: _locationController.text,
        rating: double.parse(_ratingController.text),
        amenities: amenities,
        price: double.parse(_priceController.text),
      );

      // Menampilkan snackbar dan kembali ke halaman sebelumnya
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Destination added successfully!')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Destination"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the destination name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _locationController,
                  decoration: InputDecoration(labelText: 'Location'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the location';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _ratingController,
                  decoration: InputDecoration(labelText: 'Rating (e.g., 4.5)'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the rating';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _amenitiesController,
                  decoration: InputDecoration(
                    labelText: 'Amenities (comma-separated)',
                    hintText: 'e.g., Breakfast, Lunch, Hotel AC',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter at least one amenity';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(labelText: 'Price (e.g., 196.46)'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the price';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _saveDestination,
                    child: Text("Save Destination"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
