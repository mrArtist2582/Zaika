import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  Future<void> _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'kteam4work@gmail.com',
    );
    if (!await launchUrl(emailUri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch email');
    }
  }

  Future<void> _launchPhone() async {
    final Uri phoneUri = Uri(scheme: 'tel', path: '+919904225520');
    if (!await launchUrl(phoneUri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch phone');
    }
  }

  Future<void> _launchMap() async {
    final Uri mapUri = Uri.parse("https://www.google.com/maps/search/?api=1&query=Anand,Gujarat");
    if (!await launchUrl(mapUri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch map');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "About Us",
          style: TextStyle(
            color: Color.fromRGBO(66, 66, 66, 1),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double maxWidth = constraints.maxWidth > 800 ? 800 : constraints.maxWidth;

          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Welcome to Zaika!",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "    Zaika is a modern food delivery platform committed to providing customers with a seamless and efficient way to enjoy their favorite meals. "
                      "With a user-friendly interface and a vast selection of cuisines, we bring the best restaurants to your doorstep, ensuring a hassle-free dining experience from the comfort of your home.",
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "    We prioritize customer satisfaction by maintaining high service standards, offering real-time order tracking, and ensuring timely deliveries. "
                      "Our dedicated team continuously works on improving the platform, incorporating the latest technological advancements to enhance your ordering experience.",
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "    Whether you're craving a quick snack, a hearty meal, or something new to try, Zaika connects you with the best options available. "
                      "We strive to make food delivery convenient, reliable, and enjoyable for everyone, anytime and anywhere.",
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Contact Us",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 20,
                      runSpacing: 10,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.email, color: Colors.blue),
                          title: const Text("kteam4work@gmail.com"),
                          onTap: _launchEmail,
                          contentPadding: EdgeInsets.zero,
                        ),
                        ListTile(
                          leading: const Icon(Icons.phone, color: Colors.green),
                          title: const Text("+91 9904225520"),
                          onTap: _launchPhone,
                          contentPadding: EdgeInsets.zero,
                        ),
                        ListTile(
                          leading: const Icon(Icons.location_on, color: Colors.red),
                          title: const Text("Anand, Gujarat"),
                          onTap: _launchMap,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ],
                    ),
                    const SizedBox(height: 80),
                    Center(
                      child: Text(
                        "Copyright © 2025 Zaika. All Rights Reserved",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
