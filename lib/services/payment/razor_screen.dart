import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_delivery_app/models/restauarant.dart';
import 'package:food_delivery_app/pages/delivery_progress_page.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';




class RazorScreen extends StatefulWidget {
  const RazorScreen({super.key});

  @override
  State<RazorScreen> createState() => _RazorScreenState();
}

class _RazorScreenState extends State<RazorScreen> {
  late Razorpay razorpay;

  @override
  void initState() {
    super.initState();
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<Restauarant>(context);
    double totalPrice = cartProvider.getTotalPrice();
    double gst = totalPrice * 0.05; // 5% GST
    double deliveryCharge = 40.0; // Fixed delivery charge
    double finalAmount = totalPrice + gst + deliveryCharge;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "RazorPay",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Center(
        child: OutlinedButton(
          onPressed: () {
            startPayment(finalAmount, cartProvider.deliveryAddress);
          },
          child: const Text("Pay"),
        ),
      ),
    );
  }

  void startPayment(double amount, String deliveryAddress) {
    var options = {
      'key': 'rzp_test_fWMbQfzsFEmZpy',
      'amount': (amount * 100).toInt(), // Convert to paise
      'name': 'KD Serve',
      'description': 'Food Order Payment',
      'timeout': 60, // in seconds
      'prefill': {
        'contact': '9904225520',
        'email': 'kashishdarji25@example.com'
      },
      'notes': {
        'Delivery Address': deliveryAddress,
      }
    };
    try {
      razorpay.open(options);
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: ${e.toString()}");
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(msg: "Payment Success: ${response.paymentId}");
  String paymentMethod = "RazorPay"; // Define the payment method
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => DeliveryProgressPage(paymentMethod: paymentMethod)),
  );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: "Payment Failed: ${response.message}");
  }

  @override
  void dispose() {
    try {
      razorpay.clear();
    } catch (e) {
      if (kDebugMode) {
        print("Error clearing Razorpay: $e");
      }
    }
    super.dispose();
  }
}
