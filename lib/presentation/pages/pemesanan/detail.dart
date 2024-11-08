// destination_detail.dart
import 'package:flutter/material.dart';
import 'package:project_flutter/presentation/pages/homeprofile/destination/Destination.dart';  // Import model Destination

class DestinationDetailPage extends StatelessWidget {
  final Destination destination;

  DestinationDetailPage({required this.destination});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(destination.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(destination.imagePath, fit: BoxFit.cover), // Gantilah dengan data gambar yang sesuai
            SizedBox(height: 16),
            Text(destination.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Location: ${destination.location}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Rating: ${destination.rating}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Price: \$${destination.price}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Accommodation Cleanliness: ${destination.cleanAccommodation}', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
