import 'package:flutter/material.dart';
import 'package:upi_payment_qrcode_generator/upi_payment_qrcode_generator.dart';

class MyQrCodeScreen extends StatefulWidget {
  const MyQrCodeScreen({super.key});

  @override
  State<MyQrCodeScreen> createState() => _MyQrCodeScreenState();
}

class _MyQrCodeScreenState extends State<MyQrCodeScreen> {
  //TODO Change UPI ID
  final upiDetails = UPIDetails(
      upiID: "9667945036@ybl",
      payeeName: "Karishma M",
      amount: 1,
      transactionNote: "Hello World");

  final upiDetailsWithoutAmount = UPIDetails(
    upiID: "9667945036@ybl",
    payeeName: "Karishma M",
    transactionNote: "Hello World",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UPI Payment QRCode Generator'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("UPI Payment QRCode without Amount",
              style: TextStyle(fontWeight: FontWeight.bold)),
          UPIPaymentQRCode(
            upiDetails: upiDetailsWithoutAmount,
            size: 220,
            // embeddedImagePath: 'assets/images/logo.png',
            embeddedImageSize: const Size(60, 60),
            eyeStyle: const QrEyeStyle(
              eyeShape: QrEyeShape.circle,
              color: Colors.black,
            ),
            dataModuleStyle: const QrDataModuleStyle(
              dataModuleShape: QrDataModuleShape.circle,
              color: Colors.black,
            ),
          ),
          Text(
            "Scan QR to Pay",
            style: TextStyle(color: Colors.grey[600], letterSpacing: 1.2),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text("UPI Payment QRCode with Amount",
              style: TextStyle(fontWeight: FontWeight.bold)),
          UPIPaymentQRCode(
            upiDetails: upiDetails,
            size: 220,
            upiQRErrorCorrectLevel: UPIQRErrorCorrectLevel.low,
          ),
          Text(
            "Scan QR to Pay",
            style: TextStyle(color: Colors.grey[600], letterSpacing: 1.2),
          ),
        ],
      )),
    );
  }
}
