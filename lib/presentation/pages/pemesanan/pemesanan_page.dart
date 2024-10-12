import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PemesananPage extends StatelessWidget {
  const PemesananPage({super.key});

  @override
  Widget build(BuildContext context) {
    final recommendation = Get.arguments as Map<String, String>;
    return Scaffold(
      body: Column(
        children: [
          // Image and overlay
          Stack(
            children: [
              Image.asset(
                'assets/image_pemesanan.png',
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 40,
                left: 20,
                child: Icon(Icons.arrow_back, color: Colors.white),
              ),
              Positioned(
                top: 40,
                right: 20,
                child: Icon(Icons.favorite_border, color: Colors.white),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and location
                Text(
                  recommendation['title'].toString(),
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16),
                    SizedBox(width: 4),
                    Text('Sumba Island, East Nusa Tenggara'),
                  ],
                ),
                SizedBox(height: 8),
                // Rating
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow, size: 16),
                    SizedBox(width: 4),
                    Text('4.9 (69 Reviews)'),
                  ],
                ),
                SizedBox(height: 16),
                // Amenities
                Text('Amenities',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildChip('Breakfast, Lunch & Dinner'),
                    _buildChip('Hotel AC'),
                    _buildChip('Guide/Tour Leader'),
                    _buildChip('Transportation AC'),
                    _buildChip('Tour Tickets'),
                    _buildChip('Documentation'),
                    _buildChip('Airport Shuttle'),
                    _buildChip('Mineral Water'),
                  ],
                ),
                SizedBox(height: 16),
                // Self Check-in and Clean Accommodation
                _buildInfoRow(Icons.phone_android, 'Self Check-in',
                    'Check yourself in with our mobile app'),
                SizedBox(height: 8),
                _buildInfoRow(Icons.cleaning_services, 'Clean Accommodation',
                    'CHSE-certified accommodations for applying hygiene protocol'),
                SizedBox(height: 16),
                // Price and Booking
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Price starts from'),
                        Text(
                          '\$196,46',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        Text('/ 4 Day 3 Night'),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Booking'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding:
                            EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String label) {
    return Chip(
      label: Text(label, style: TextStyle(fontSize: 12)),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String subtitle) {
    return Row(
      children: [
        Icon(icon),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ],
    );
  }
}
