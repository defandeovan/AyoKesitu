import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SumbaIslandScreen(),
    );
  }
}

class SumbaIslandScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/img/Mask Group.png',
                  height: 400,
                  width: 393,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 40,
                  left: 10,
                  child: Icon(Icons.arrow_back, color: Colors.white),
                ),
                Positioned(
                  top: 40,
                  right: 10,
                  child: Icon(Icons.favorite_border, color: Colors.white),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sumba Island',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/img/Map Pin.png',
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Sumba Island, East Nusa Tenggara',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      Text(
                        '4.9',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        ' (69 Reviews)',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Amenities',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 150, // Lebar container
                            margin: EdgeInsets.only(
                                right: 8, bottom: 8), // Margin antar container
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: Text(
                                'Breakfast, Lunch & Dinner',
                                style:
                                    TextStyle(fontSize: 8, color: Colors.black),
                              ),
                            ),
                          ),
                          Container(
                            width: 150,
                            margin: EdgeInsets.only(right: 8, bottom: 8),
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: Text(
                                'Hotel AC',
                                style:
                                    TextStyle(fontSize: 8, color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 150,
                            margin: EdgeInsets.only(right: 8, bottom: 8),
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: Text(
                                'Guide/Tour Leader',
                                style:
                                    TextStyle(fontSize: 8, color: Colors.black),
                              ),
                            ),
                          ),
                          Container(
                            width: 150,
                            margin: EdgeInsets.only(right: 8, bottom: 8),
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: Text(
                                'Transportation AC',
                                style:
                                    TextStyle(fontSize: 8, color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 150,
                            margin: EdgeInsets.only(right: 8, bottom: 8),
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: Text(
                                'Tour Tickets',
                                style:
                                    TextStyle(fontSize: 8, color: Colors.black),
                              ),
                            ),
                          ),
                          Container(
                            width: 150,
                            margin: EdgeInsets.only(right: 8, bottom: 8),
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: Text(
                                'Documentation',
                                style:
                                    TextStyle(fontSize: 8, color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 150,
                            margin: EdgeInsets.only(right: 8, bottom: 8),
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: Text(
                                'Airport Shuttle',
                                style:
                                    TextStyle(fontSize: 8, color: Colors.black),
                              ),
                            ),
                          ),
                          Container(
                            width: 150,
                            margin: EdgeInsets.only(right: 8, bottom: 8),
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: Text(
                                'Mineral Water',
                                style:
                                    TextStyle(fontSize: 8, color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),SizedBox(height: 8,),
                  Padding(
                    padding: const EdgeInsets.only(left: 32.0),
                    child: Text(
                      'Check yourself in with our mobile app',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green),
                      SizedBox(width: 8),
                      Text('Clean Accommodation'),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 32.0),
                    child: Text(
                      'CHSE-certified accommodations for applying hygiene protocol',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Price starts from',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    '\$196.46 / 4 Day 3 Night',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Booking'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      backgroundColor: Colors.teal,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
