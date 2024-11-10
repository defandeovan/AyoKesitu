import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_flutter/app/modules/payment/views/confirm.dart';


class PaymentView extends StatefulWidget {
  @override
  _MyCheckoutPageState createState() => _MyCheckoutPageState();
}

class _MyCheckoutPageState extends State<PaymentView> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text('Checkout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StepperWidget(),
            SizedBox(height: 16),
            Text(
              'Select a payment method',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Please select a payment method most convenient to you.'),
            SizedBox(height: 16),
            PaymentMethodWidget(),
            SizedBox(height: 16),
            PaymentForm(),
            SizedBox(height: 16),
            Row(
              children: [
                Checkbox(value: isChecked, onChanged: (bool? value) {setState(() {
              isChecked = value!; // ubah status checkbox
            });}),
                Text("My billing address is the same as my shipping address."),
              ],
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Get.to(CheckoutConfirmationPage());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                ),
                child: Text('Confirm'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StepperWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StepCircle(isActive: true, label: '1'),
        Expanded(
          child: Divider(thickness: 2, color: Colors.blue),
        ),
        StepCircle(isActive: false, label: '2'),
      ],
    );
  }
}

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

class PaymentMethodWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        PaymentMethodIcon(image: 'assets/img/visa.png'),
        PaymentMethodIcon(image: 'assets/img/paypal.png'),
        PaymentMethodIcon(image: 'assets/img/dana.png'),
        PaymentMethodIcon(image: 'assets/img/qris.png'),
      ],
    );
  }
}

class PaymentMethodIcon extends StatelessWidget {
  final String image;

  PaymentMethodIcon({required this.image});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      height: 50,
      width: 80,
    );
  }
}

class PaymentForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          decoration: InputDecoration(border :OutlineInputBorder(borderRadius: BorderRadius.circular(10)),labelText: 'Credit Card'),
        ),
        SizedBox(height: 16),
        TextFormField(
          decoration: InputDecoration(border :OutlineInputBorder(borderRadius: BorderRadius.circular(10)),labelText: 'Name'),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(border :OutlineInputBorder(borderRadius: BorderRadius.circular(10)), labelText: 'Expiration Date'),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(border :OutlineInputBorder(borderRadius: BorderRadius.circular(10)),labelText: 'CVV'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
