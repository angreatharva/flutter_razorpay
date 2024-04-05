import 'package:flutter/material.dart';
import 'package:razorpay_web/razorpay_web.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Razorpay razorpay;

  @override
  void initState() {
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, errorHandler);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, successHandler);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, externalWalletHandler);
    super.initState();
  }

  TextEditingController amountController = TextEditingController();
  void errorHandler(PaymentFailureResponse response) {
    print("response08 message: ${response.message!}");
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(response.message!),
      backgroundColor: Colors.red,
    ));
  }

  void successHandler(PaymentSuccessResponse response) {
    print("response08 paymentId: ${response.paymentId!}");
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(response.paymentId!),
      backgroundColor: Colors.green,
    ));
  }

  void externalWalletHandler(ExternalWalletResponse response) {
    print("response08 walletName: ${response.walletName!}");
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(response.walletName!),
      backgroundColor: Colors.green,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Razor pay")),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: amountController,
                  decoration: const InputDecoration(
                    hintText: "Amount",
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 0.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 0.0)),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 0.0)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                onPressed: () {
                  openCheckout();
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 70, vertical: 15),
                  child: Text("Pay now"),
                ),
              ),
            ],
          )),
    );
  }

  void openCheckout() {
    var options = {
      "key": "rzp_test_guh6g0JMXMv65d",
      "amount": num.parse(amountController.text) * 100,
      "name": "Atharva Angre",
      "description": " this is the test payment",
      "timeout": "600",
      "currency": "INR",
      "prefill": {
        "contact": "9167449720",
        "email": "angreatharva08@gmail.com",
      }
    };
    razorpay.open(options);
  }
}