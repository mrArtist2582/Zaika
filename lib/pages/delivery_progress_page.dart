import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/my_receipt_page.dart';
import 'package:food_delivery_app/models/restauarant.dart';
import 'package:food_delivery_app/pages/cart_page.dart';
import 'package:food_delivery_app/services/database/firestore.dart';
import 'package:provider/provider.dart';

class DeliveryProgressPage extends StatefulWidget {
  final String paymentMethod;

  const DeliveryProgressPage({super.key, required this.paymentMethod});

  @override
  State<DeliveryProgressPage> createState() => _DeliveryProgressPageState();
}

class _DeliveryProgressPageState extends State<DeliveryProgressPage> {
  // Firestore service instance
  final FirestoreService db = FirestoreService();
  late String receipt;
  late String finalPaymentMethod;

  @override
  void initState() {
    super.initState();

    // Assign payment method properly
    finalPaymentMethod = widget.paymentMethod.trim().isNotEmpty
        ? widget.paymentMethod
        : "Not Provided";

    debugPrint("Payment Method in DeliveryProgressPage (initState): $finalPaymentMethod");

    // Get the receipt from the restaurant provider
    receipt = context.read<Restauarant>().displayCartReceipt(); 
    // Save the order to Firestore with correct parameters
    db.saveOrderToDatabase(receipt, finalPaymentMethod);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Payment Method in DeliveryProgressPage (build): $finalPaymentMethod");

    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Progress", style: TextStyle(
          color:Colors.grey 
        ),),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(onPressed: (){
             Provider.of<Restauarant>(context, listen: false).clearCart();

                  // Navigate to HomePage and remove previous pages from stack
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => CartPage()),
                    (route) => false,
                  );
        }, icon: Icon(Icons.arrow_back_ios),)
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Pass both receipt and paymentMethod correctly
              MyReceiptPage(receipt: receipt, paymentMethod: finalPaymentMethod),
            ],
          ),
        ),
      ),
    );
  }
}
