// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';

class PaytmPayment extends StatefulWidget {
  const PaytmPayment({super.key});

  @override
  State<PaytmPayment> createState() => _PaytmPaymentState();
}

class _PaytmPaymentState extends State<PaytmPayment> {
  String mid = "";
  String orderId = "";
  String amount = "";
  String txnToken = "";
  String result = "";
  bool isStaging = false;
  bool isApiCallInprogress = false;
  String callbackUrl = "";
  bool restrictAppInvoke = false;
  bool enableAssist = true;
  TextEditingController midTextEditingController = TextEditingController();
  TextEditingController orderIdTextEditingController = TextEditingController();
  TextEditingController amountTextEditingController = TextEditingController();
  TextEditingController txnTokenTextEditingController = TextEditingController();
  TextEditingController resultTextEditingController = TextEditingController();

  @override
  void initState() {
    if (kDebugMode) {
      print("initState");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(8),
          child: Column(
            children: [
              TextField(
                controller: midTextEditingController,
                onChanged: (value) => mid = value,
                decoration: const InputDecoration(labelText: 'Merchant ID'),
              ),
              TextField(
                controller: orderIdTextEditingController,
                onChanged: (value) => orderId = value,
                decoration: const InputDecoration(labelText: 'Order ID'),
              ),
              TextField(
                controller: amountTextEditingController,
                onChanged: (value) => amount = value,
                decoration: const InputDecoration(labelText: 'Amount'),
              ),
              TextField(
                controller: txnTokenTextEditingController,
                onChanged: (value) => txnToken = value,
                decoration:
                    const InputDecoration(labelText: 'Transaction Token'),
              ),
              TextField(
                controller: resultTextEditingController,
                onChanged: (value) => callbackUrl = value,
                decoration: const InputDecoration(labelText: 'CallBack URL'),
              ),

              // EditText('Merchant ID', mid, onChange: (val) => mid = val),
              // EditText('Order ID', orderId, onChange: (val) => orderId = val),
              // EditText('Amount', amount, onChange: (val) => amount = val),
              // EditText('Transaction Token', txnToken,
              //     onChange: (val) => txnToken = val),
              // EditText('CallBack URL', callbackUrl,
              //     onChange: (val) => callbackUrl = val),
              Row(
                children: [
                  Checkbox(
                      activeColor: Colors.lightBlue,
                      value: isStaging,
                      onChanged: (bool? val) {
                        setState(() {
                          isStaging = val!;
                        });
                      }),
                  const Text("Staging")
                ],
              ),
              Row(
                children: [
                  Checkbox(
                      activeColor: Colors.lightBlue,
                      value: restrictAppInvoke,
                      onChanged: (bool? val) {
                        setState(() {
                          restrictAppInvoke = val!;
                        });
                      }),
                  const Text("Restrict AppInvoke")
                ],
              ),
              Container(
                margin: const EdgeInsets.all(16),
                child: ElevatedButton(
                    onPressed: isApiCallInprogress
                        ? null
                        : () {
                            _startTransaction();
                          },
                    child: const Text('Start Transcation')),
              ),
              Container(
                alignment: Alignment.bottomLeft,
                child: const Text("Message : "),
              ),
              Text(result),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _startTransaction() async {
    if (txnToken.isEmpty) {
      return;
    }
    var sendMap = <String, dynamic>{
      "mid": mid,
      "orderId": orderId,
      "amount": amount,
      "txnToken": txnToken,
      "callbackUrl": callbackUrl,
      "isStaging": isStaging,
      "restrictAppInvoke": restrictAppInvoke,
      "enableAssist": enableAssist
    };
    if (kDebugMode) {
      print(sendMap);
    }
    try {
      var response = AllInOneSdk.startTransaction(mid, orderId, amount,
          txnToken, callbackUrl, isStaging, restrictAppInvoke, enableAssist);
      response.then((value) {
        if (kDebugMode) {
          print(value);
        }
        setState(() {
          result = value.toString();
        });
      }).catchError((onError) {
        if (onError is PlatformException) {
          setState(() {
            result = "${onError.message} \n  ${onError.details}";
          });
        } else {
          setState(() {
            result = onError.toString();
          });
        }
      });
    } catch (err) {
      result = err.toString();
    }
  }
}
