import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/payment_configurations.dart';
import 'package:flutter_application_1/view/qrcode_screen.dart';
import 'package:flutter_application_1/view/upi_india_screen.dart';
import 'package:pay/pay.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var googlePayButton = GooglePayButton(
    paymentConfiguration: PaymentConfiguration.fromJsonString(defaultGooglePay),
    paymentItems: const [
      PaymentItem(
        label: 'Total',
        amount: '0.01',
        status: PaymentItemStatus.final_price,
      )
    ],
    type: GooglePayButtonType.pay,
    margin: const EdgeInsets.only(top: 15.0),
    onPaymentResult: (result) => debugPrint(result.toString()),
    loadingIndicator: const Center(
      child: CircularProgressIndicator(),
    ),
  );

  var applePayButton = ApplePayButton(
    paymentConfiguration: PaymentConfiguration.fromJsonString(defaultApplePay),
    paymentItems: const [
      PaymentItem(
        label: 'Total',
        amount: '0.01',
        status: PaymentItemStatus.final_price,
      )
    ],
    style: ApplePayButtonStyle.black,
    type: ApplePayButtonType.buy,
    margin: const EdgeInsets.only(top: 15.0),
    onPaymentResult: (result) => debugPrint(result.toString()),
    loadingIndicator: const Center(
      child: CircularProgressIndicator(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Payment Gateways"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Platform.isIOS ? applePayButton : googlePayButton,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                // const PaytmPayment(),
                // const SizedBox(
                //   height: 10.0,
                // ),
                Container(
                  margin: const EdgeInsets.all(16),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyQrCodeScreen()));
                      },
                      child: const Text('QR Code Generator')),
                ),

                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  margin: const EdgeInsets.all(16),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const UpiIndiaPay()));
                      },
                      child: const Text('UPI India')),
                )

              ],
            ),
          ),
        ));
  }
}
