import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/my_button.dart';
import 'package:food_delivery_app/models/restauarant.dart';
import 'package:food_delivery_app/pages/home_page.dart';
import 'package:provider/provider.dart';

class MyReceiptPage extends StatelessWidget {
  final String paymentMethod;
  final String receipt;

  const MyReceiptPage({
    super.key,
    required this.paymentMethod,
    required this.receipt,
  });

  @override
  Widget build(BuildContext context) {
    DateTime estimatedTime = DateTime.now().add(const Duration(minutes: 25));
    String formattedTime =
        "${estimatedTime.hour}:${estimatedTime.minute.toString().padLeft(2, '0')}";

    

    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Thank you for your Order!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,
                color: Colors.grey),
              ),
              const SizedBox(height: 25),
              Text(
                "Estimated delivery time: $formattedTime",
                style: const TextStyle(fontSize: 16 , color:Colors.grey),
              ),

              // Receipt Container
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      receipt,
                      style: const TextStyle(fontSize: 16 , color: Colors.grey),
                    ),
                    const SizedBox(height: 15),
                    Divider(color: Theme.of(context).colorScheme.inversePrimary),
                    const SizedBox(height: 10),
                     
                    // Payment Method inside the container
                    Text(
                      "Payment Method: ${paymentMethod.isNotEmpty ? paymentMethod : "Not Provided"}",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 55),

              // Close Button
              MyButton(
                onTap: () {
                  // Clear the cart before navigating to HomePage
                  Provider.of<Restauarant>(context, listen: false).clearCart();

                  // Navigate to HomePage and remove previous pages from stack
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                    (route) => false,
                  );
                },
                text: "Close",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
