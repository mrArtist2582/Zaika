import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  // Function to launch Email
  Future<void> _launchEmail(BuildContext context) async {
    final Uri emailUri = Uri(scheme: 'mailto', path: 'kteam4work@gmail.com');
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri, mode: LaunchMode.externalApplication);
    } else {
      
    }
  }

  // Function to launch Phone
  Future<void> _launchPhone(BuildContext context) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: '+919904225520');
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri, mode: LaunchMode.externalApplication);
    } else {
      
    }
  }

  // Function to launch Google Maps
  Future<void> _launchMap(BuildContext context) async {
    final Uri mapUri =
        Uri.parse("https://www.google.com/maps/search/?api=1&query=Anand,Gujarat");
    if (await canLaunchUrl(mapUri)) {
      await launchUrl(mapUri, mode: LaunchMode.externalApplication);
    } else {
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "About Us",
          style: TextStyle(color: Colors.grey),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome to K4Serve!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10),
            Text(
              "    K4Serve is a modern food delivery platform committed to providing customers with a seamless and efficient way to enjoy their favorite meals. With a user-friendly interface and a vast selection of cuisines, we bring the best restaurants to your doorstep, ensuring a hassle-free dining experience from the comfort of your home.",
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10),
            Text(
              "    We prioritize customer satisfaction by maintaining high service standards, offering real-time order tracking, and ensuring timely deliveries. Our dedicated team continuously works on improving the platform, incorporating the latest technological advancements to enhance your ordering experience.",
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10),
            Text(
              "    Whether you're craving a quick snack, a hearty meal, or something new to try, K4Serve connects you with the best options available. We strive to make food delivery convenient, reliable, and enjoyable for everyone, anytime and anywhere.",
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 20),
            Text(
              "Contact Us",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.email, color: Colors.blue),
              title: Text("kteam4work@gmail.com"),
              onTap: () => _launchEmail(context), // Use context
            ),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.green),
              title: Text("+91 9904225520"),
              onTap: () => _launchPhone(context), // Use context
            ),
            ListTile(
              leading: Icon(Icons.location_on, color: Colors.red),
              title: Text("Anand, Gujarat"),
              onTap: () => _launchMap(context), // Use context
            ),
            SizedBox(height: 90),
        
            Center(
              child: Text(
                "Copyright © 2025 K4Serve. All Rights Reserved",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
