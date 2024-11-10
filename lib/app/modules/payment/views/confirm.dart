import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutConfirmationPage extends StatelessWidget {
  const CheckoutConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
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
            PaymentSummary(),
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
                onPressed: () {
                  // Action when continue button is pressed
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                ),
                child: Text('Continue'),
              ),
            ),
          ],
        ),
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

// Payment Summary Widget
class PaymentSummary extends StatelessWidget {
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
          Text('Payment', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Subtotal'),
              Text('2.990.000'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Delivery'),
              Text('2.500'),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('2.992.500', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
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
              Text('Payment', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
              Text('Shipping address', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
