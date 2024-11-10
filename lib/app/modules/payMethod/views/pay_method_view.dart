import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_flutter/app/modules/payMethod/controllers/pay_method_controller.dart';


class PaymentMethodView extends StatelessWidget {
  final PayMethodController controller = Get.put(PayMethodController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment method'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment method',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            Obx(() => Column(
                  children: [
                    paymentMethodTile(
                        'GOPAY', 'assets/img/gopay_icon.png', controller),
                    paymentMethodTile(
                        'Paypal', 'assets/img/paypal_icon.png', controller),
                    paymentMethodTile('Credit Card',
                        'assets/img/creditcard_icon.png', controller),
                    paymentMethodTile('Mobile Banking BCA',
                        'assets/img/bca_icon.png', controller),
                    paymentMethodTile(
                        'DANA', 'assets/img/dana_icon.png', controller),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget paymentMethodTile(
      String methodName, String iconPath, PayMethodController controller) {
    return ListTile(
      leading: Image.asset(iconPath, width: 24),
      title: Text(methodName),
      trailing: controller.selectedMethod.value == methodName
          ? Icon(Icons.radio_button_checked, color: Colors.blue)
          : Icon(Icons.radio_button_off),
      onTap: () {
        controller.selectMethod(methodName);
      },
    );
  }
}
