import 'package:flutter/material.dart';
import 'package:food_delivery_app/services/firebase/firebase_uploader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:food_delivery_app/intro/intro_screen.dart';
import 'package:food_delivery_app/services/auth/auth_gate.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery_app/models/restauarant.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToNextScreen();
  }

 void navigateToNextScreen() async {
  await Future.delayed(const Duration(seconds: 3));

  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Check if menu was already uploaded
  bool isMenuUploaded = prefs.getBool('menuUploaded') ?? false;

  if (!isMenuUploaded) {
    final restaurant = Provider.of<Restauarant>(context, listen: false);
    await FirebaseUploader.uploadMenu(restaurant.menu);
    await prefs.setBool('menuUploaded', true); // Mark as uploaded
  }

  // Handle intro screen check
  bool hasSeenIntro = prefs.getBool('hasSeenIntro') ?? false;
  if (!hasSeenIntro) {
    await prefs.setBool('hasSeenIntro', true);
  }

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (_) => hasSeenIntro ? const AuthGate() : const IntroScreen(),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/bgmain.png',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
