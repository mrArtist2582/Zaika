import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/my_button.dart';
import 'package:food_delivery_app/components/my_text_field.dart';
import 'package:food_delivery_app/pages/profile_creation_page.dart';
import 'package:food_delivery_app/services/auth/auth_service.dart';
import 'package:food_delivery_app/pages/home_page.dart';
import 'package:google_sign_in/google_sign_in.dart';
class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isPasswordVisible = false;
  late AnimationController _controller;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    _checkUserLogin();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    _fadeIn = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _controller.forward();
  }

  void _checkUserLogin() {
    final user = _authService.getCurrentUser();
    if (user != null) {
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
      });
    }
  }

  void login() async {
    try {
      await _authService.signInWithEmailPassword(emailController.text, passwordController.text);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfileCreationPage()));
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Login Failed"),
          content: Text(e.toString()),
          actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK"))],
        ),
      );
    }
  }

  void googleLogin() async {
      // ignore: unused_local_variable
      final googleSignIn = GoogleSignIn(
  clientId: '419173628101-hor883tcfep3ik3gb0bm0gt133qavips.apps.googleusercontent.com',
);

    try {
      final user = await _authService.loginWithGoogle();
      if (user != null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfileCreationPage()));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Google login failed: ${e.toString()}")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: FadeTransition(
        opacity: _fadeIn,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                children: [
                  Image.asset('assets/bgmain.png', height: 120),
                  const SizedBox(height: 10),
                  Text('Welcome to Zaika...', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 25),

                  // Card with fields and buttons
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          MyTextField(
                            controller: emailController,
                            hintText: "Email",
                            obsecureText: false,
                          ),
                          const SizedBox(height: 15),
                          TextField(
                            controller: passwordController,
                            obscureText: !_isPasswordVisible,
                            decoration: InputDecoration(
                              hintText: "Password",
                              suffixIcon: IconButton(
                                icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                                onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                              ),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                          const SizedBox(height: 20),
                          MyButton(onTap: login, text: "Sign in"),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Register row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Not a member?', style: Theme.of(context).textTheme.bodyMedium),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(' Register now...', style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Google login
                  GestureDetector(
                    onTap: googleLogin,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset('assets/google.png', height: 30),
                          const SizedBox(width: 10),
                          const Text("Continue with Google", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
