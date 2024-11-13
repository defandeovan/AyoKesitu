import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project_flutter/app/modules/payment/controllers/payment_controller.dart';

class PaymentSuccessPage extends StatelessWidget {
  final PaymentController controller = Get.put(PaymentController());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.blue,
                  size: 80.0,
                ),
                SizedBox(height: 16.0),
                Text(
                  "Payment Successful",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  "successfully paid 2,992,500 to AyoKetsu",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Divider(thickness: 1.0, color: Colors.grey.shade300),
                SizedBox(height: 16.0),
                _buildInfoRow("Transaction Number", "1234 5678 9932"),
                _buildInfoRow("Date", "19 August 2045 - 12:45"),
                _buildInfoRow("Status", "Success", success: true),
                _buildInfoRow("Type of Transactions", "QRIS"),
                _buildInfoRow("Nominal", "Rp 2,992,500"),
                SizedBox(height: 24.0),
                Text(
                  "Rp 2,992,500",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.green),
                ),
                SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 40.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    "Continue",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value, {bool success = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 14, color: Colors.grey)),
          success
              ? Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green, size: 16.0),
                    SizedBox(width: 4.0),
                    Text(value, style: TextStyle(fontSize: 14, color: Colors.green)),
                  ],
                )
              : Text(value, style: TextStyle(fontSize: 14, color: Colors.black)),
        ],
      ),
    );
  }
}
