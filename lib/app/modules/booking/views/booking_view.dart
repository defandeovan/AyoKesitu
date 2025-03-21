import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_flutter/app/data/Destination.dart';
import 'package:project_flutter/app/modules/payment/views/confirm.dart';
import 'package:project_flutter/app/modules/payment/views/payment_view.dart';

class BookingView extends StatelessWidget {
  final box = GetStorage(); // Inisialisasi GetStorage

  // Menyimpan data orderan ke GetStorage
 void saveOrderData(Map<String, dynamic> orderData) {
  // Ambil daftar order dari GetStorage
  final data = box.read('orders'); // Membaca data dari GetStorage
  List<Map<String, dynamic>> orders = [];

  if (data != null && data is List) {
    // Validasi tipe data dan konversi
    orders = data
        .map((e) => e is Map<String, dynamic> ? e : {})
        .toList()
        .cast<Map<String, dynamic>>();
  }

  // Tambahkan data pesanan baru ke dalam daftar
  orders.add(orderData);

  // Simpan kembali daftar pesanan ke GetStorage
  box.write('orders', orders);
}


  // Membaca data orderan dari GetStorage
  List<Map<String, dynamic>> getOrderData() {
    return box.read('orders') ?? [];
  }

  final Destination destination;

  BookingView({required this.destination});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              Image.network(
                destination.img,
                height: 400,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 40,
                left: 10,
                child: GestureDetector(onTap: (){
                  Get.back();
                },
                child: Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
             
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  destination.name,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Image.asset('assets/img/Map Pin.png'),
                    SizedBox(width: 4),
                    Text(
                      '${destination.location}',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    Text(
                      '${destination.rating}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      ' (69 Reviews)',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
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
                  'Amenities',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: (destination.amenities ?? [])
                      .map((amenity) =>
                          _buildAmenityContainer(amenity.toString()))
                      .toList(),
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
                Row(
                  children: [
                    Image.asset('assets/img/Thumbs up.png'),
                    SizedBox(width: 8),
                    Text(
                      'Self Check-in',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 32.0),
                  child: Text(
                    '${destination.selfCheckIn}',
                    style: TextStyle(color: Colors.grey, fontSize: 9),
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Image.asset('assets/img/Check circle.png'),
                    SizedBox(width: 8),
                    Text(
                      'Clean Accommodation',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 32.0),
                  child: Text(
                    '${destination.cleanAccommodation}',
                    style: TextStyle(color: Colors.grey, fontSize: 9),
                  ),
                ),
                SizedBox(height: 24),
              ],
            ),
          ),
          Container(
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Price starts from',
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      '${destination.price}',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF00A550),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    // Data order baru
                    Map<String, dynamic> order = {
                      'destination': destination.name,
                      'price': destination.price,
                      'date': DateTime.now().toString(),
                    };

                    // Simpan data order
                    saveOrderData(order);

                    // Arahkan ke halaman pembayaran
                    Get.to(() => PaymentView());
                  },
                  child: Text(
                    'Booking',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF00A550),
                    padding: EdgeInsets.symmetric(horizontal: 43, vertical: 9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}

Widget _buildAmenityContainer(String text) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(16),
    ),
    child: Text(
      text,
      style: TextStyle(fontSize: 8, color: Colors.black),
    ),
  );
}
