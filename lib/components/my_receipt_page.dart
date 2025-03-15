import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/my_button.dart';
import 'package:food_delivery_app/models/restauarant.dart';
import 'package:food_delivery_app/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

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
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              const SizedBox(height: 25),
              Text(
                "Estimated delivery time: $formattedTime",
                style: const TextStyle(fontSize: 16, color: Colors.grey),
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
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 15),
                    Divider(
                        color: Theme.of(context).colorScheme.inversePrimary),
                    const SizedBox(height: 10),

                    // Payment Method inside the container
                    Text(
                      "Payment Method: ${paymentMethod.isNotEmpty ? paymentMethod : "Not Provided"}",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // Print Invoice Button
              TextButton(
                  onPressed: () async {
                    await _generateInvoice(context, receipt, paymentMethod);
                  },
                  child: Text("Get Invoice")),

              const SizedBox(height: 25),

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

  // Function to check permission and save invoice PDF
 Future<void> _generateInvoice(BuildContext context, String receipt, String paymentMethod) async {
  try {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text("Invoice", style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              pw.Text("Thank you for your Order!", style: pw.TextStyle(fontSize: 18, color: PdfColors.grey)),
              pw.SizedBox(height: 10),
              pw.Text(receipt, style: pw.TextStyle(fontSize: 14)),
              pw.Divider(),
              pw.Text("Payment Method: ${paymentMethod.isNotEmpty ? paymentMethod : "Not Provided"}",
                  style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
            ],
          );
        },
      ),
    );

    // Get directory
    Directory directory = await getApplicationDocumentsDirectory();
    final filePath = "${directory.path}/invoice.pdf";

    // Save the PDF file
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Get your Invoice"),
        action: SnackBarAction(
          label: "Open",
          onPressed: () {
            OpenFile.open(filePath);
          },
        ),
      ),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Failed to save invoice: ${e.toString()}")),
    );
  }
}

}
