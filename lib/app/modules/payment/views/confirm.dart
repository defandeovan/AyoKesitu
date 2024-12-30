import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_flutter/app/modules/payment/views/success.dart';

import 'package:get_storage/get_storage.dart';

class CheckoutConfirmationPage extends StatelessWidget {
  CheckoutConfirmationPage({super.key});

  final AudioPlayer _audioPlayer = AudioPlayer();
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    // Ambil data terbaru dari GetStorage
    List<dynamic> latestOrders = box.read<List<dynamic>>('orders') ?? [];
    // Data terbaru (misalnya, data terakhir dalam list)
    var latestOrder = latestOrders.isNotEmpty ? latestOrders.last : null;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text('Checkout'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Step indicator
            Row(
              children: [
                StepCircle(isActive: true, label: '1'),
                Expanded(
                  child: Divider(thickness: 2, color: Colors.blue),
                ),
                StepCircle(isActive: true, label: '2'),
              ],
            ),
            SizedBox(height: 16),

            // Payment summary
            latestOrder != null
                ? PaymentSummary(orderData: latestOrder)
                : Text("No order data available."),
            SizedBox(height: 16),

            // Confirmation text
            Text(
              'Please confirm and submit your order',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'By clicking submit order, you agree to terms of Use and privacy policy',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 16),

            // Payment method section
            PaymentDetailSection(),

            SizedBox(height: 16),

            // Shipping address section
            ShippingAddressSection(),

            Spacer(),

            // Continue button
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                ),
                child: Text('Continue'),
                onPressed: () async {
                  // Action when continue button is pressed

                  try {
                    await _audioPlayer
                        .play(AssetSource('sounds/musik_mobile.mp3'));
                    print('Audio playing...');
                  } catch (e) {
                    print("Error : $e");
                  }
                  _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
                    print('Player status: $state');
                  });
                  Get.to(() => PaymentSuccessPage());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Update PaymentSummary untuk menerima data dinamis
class PaymentSummary extends StatelessWidget {
  final Map<String, dynamic> orderData;

  PaymentSummary({required this.orderData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[100],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Payment',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Destination'),
              Text(orderData['destination'] ?? 'Unknown'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Price'),
              Text('${orderData['price'] ?? 0}'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Date'),
              Text(orderData['date'] ?? 'Unknown'),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('${orderData['total'] ?? 0}',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}


// Stepper Circle Widget
class StepCircle extends StatelessWidget {
  final bool isActive;
  final String label;

  StepCircle({required this.isActive, required this.label});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 18,
      backgroundColor: isActive ? Colors.blue : Colors.grey[300],
      child: Text(label, style: TextStyle(color: Colors.white)),
    );
  }
}

// Payment Detail Section
class PaymentDetailSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Payment',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Row(
                children: [
                  Image.asset('assets/img/visa.png', height: 24), // Visa logo
                  SizedBox(width: 8),
                  Text('**** **** **** 5527'),
                  SizedBox(width: 16),
                  Text('07/35'),
                ],
              ),
            ],
          ),
          Spacer(),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Edit action
            },
          ),
        ],
      ),
    );
  }
}

// Shipping Address Section
class ShippingAddressSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Shipping address',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.grey),
                  SizedBox(width: 8),
                  Text('Tlogomas, Malang, East Java, No.44'),
                ],
              ),
            ],
          ),
          Spacer(),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Edit action
            },
          ),
        ],
      ),
    );
  }
}
