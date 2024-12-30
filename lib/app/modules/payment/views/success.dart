import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart'; // Untuk format angka
import 'package:project_flutter/app/modules/payment/controllers/payment_controller.dart';
import 'package:project_flutter/app/modules/yourOrder/views/your_order_view.dart';
import 'package:audioplayers/audioplayers.dart'; // Tambahkan ini untuk audio

class PaymentSuccessPage extends StatefulWidget {
  @override
  _PaymentSuccessPageState createState() => _PaymentSuccessPageState();
}

class _PaymentSuccessPageState extends State<PaymentSuccessPage> {
  final PaymentController controller = Get.put(PaymentController());
  final box = GetStorage();
  Map<String, dynamic>? latestPayment;
  Map<String, dynamic>? orderData;
  final AudioPlayer _audioPlayer = AudioPlayer(); // Inisialisasi AudioPlayer

  @override
  void initState() {
    super.initState();
    // Ambil seluruh data orders dari GetStorage
    List<Map<String, dynamic>> orders =
        box.read<List<dynamic>>('orders')?.cast<Map<String, dynamic>>() ?? [];
    List<Map<String, dynamic>> payments =
        box.read<List<dynamic>>('payments')?.cast<Map<String, dynamic>>() ?? [];

    // Pilih data terbaru dari orders dan payments
    if (orders.isNotEmpty) {
      orderData = orders.last;
    }
    if (payments.isNotEmpty) {
      latestPayment = payments.last;
    }

    // Mainkan efek suara saat halaman dimuat
    _playSuccessAudio();
  }

  @override
  void dispose() {
    // Hentikan audio dan hapus sumber daya saat halaman dihancurkan
    _audioPlayer.stop();
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playSuccessAudio() async {
    try {
      // Path file audio (pastikan sudah didaftarkan di pubspec.yaml)
      await _audioPlayer.play(AssetSource('/sounds/musik_mobile.mp3'));
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Fungsi format nominal ke Rupiah
    String formatCurrency(dynamic amount) {
      final formatter =
          NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);
      try {
        if (amount is double) {
          return formatter.format(amount);
        }
        if (amount is String) {
          return formatter.format(double.parse(amount));
        }
        return "Rp 0";
      } catch (e) {
        return "Rp 0";
      }
    }

    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
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
                  latestPayment?['message'] ?? "Your payment was successful.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Divider(thickness: 1.0, color: Colors.grey.shade300),
                SizedBox(height: 16.0),
                _buildInfoRow(
                    "Transaction Number",
                    latestPayment?['transactionNumber'] ??
                        '1h12323y911321983g91'),
                _buildInfoRow(
                    "Destination", orderData?['destination'] ?? 'Unknown'),
                _buildInfoRow(
                    "Price", formatCurrency(orderData?['price'] ?? '0.0')),
                _buildInfoRow("Date", orderData?['date'] ?? 'Unknown'),
                SizedBox(height: 24.0),
                Text(
                  formatCurrency(orderData?['price'] ?? '0.0'),
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
                SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => YourOrderPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 40.0),
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
                    Text(value,
                        style: TextStyle(fontSize: 14, color: Colors.green)),
                  ],
                )
              : Text(value,
                  style: TextStyle(fontSize: 14, color: Colors.black)),
        ],
      ),
    );
  }
}
