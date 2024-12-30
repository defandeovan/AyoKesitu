import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart'; // Import GetStorage

class YourOrderPage extends StatelessWidget {
  final box = GetStorage(); // GetStorage instance untuk mengambil data order

  @override
  Widget build(BuildContext context) {
    // Mengambil data pesanan dari GetStorage
    List<Map<String, dynamic>> orders = box.read('orders') ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
      ),
      body: orders.isNotEmpty
          ? ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Menampilkan Gambar Destination
                      order['image'] != null && order['image'].isNotEmpty
                          ? ClipRRect(
                              borderRadius:
                                  BorderRadius.vertical(top: Radius.circular(16.0)),
                              child: Image.network(
                                order['image'],
                                height: 200.0,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(
                              height: 200.0,
                              width: double.infinity,
                              color: Colors.grey[300],
                              child: Center(
                                child: Icon(Icons.image, color: Colors.white),
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Menampilkan Destination
                            Text(
                              order['destination'] ?? 'Destination not available',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            // Menampilkan Price
                            Text(
                              'Price: Rp ${order['price']}',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.green,
                              ),
                            ),
                            SizedBox(height: 8),
                            // Menampilkan Tanggal Pemesanan
                            Text(
                              'Date: ${order['date']}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          : Center(
              child: Text(
                'No orders found',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
    );
  }
}
