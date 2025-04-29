import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/my_button.dart';
import 'package:food_delivery_app/components/my_text_field.dart';
import 'package:food_delivery_app/pages/home_page.dart';
import 'package:food_delivery_app/pages/profile_creation_page.dart';
import 'package:food_delivery_app/services/auth/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final AuthService _authService = AuthService();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;

  late AnimationController _controller;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    checkUserStatus();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _fadeIn = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _controller.forward();
  }

  void checkUserStatus() {
    final user = _authService.getCurrentUser();
    if (user != null) {
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      });
    }
  }

  void register() async {
    if (passwordController.text != confirmPasswordController.text) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: const Text("Passwords don't match!"),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      await _authService.signUpWithEmailPassword(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProfileCreationPage()),
      );
    } catch (e) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Registration Failed"),
          content: Text(e.toString()),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"))
          ],
        ),
      );
    } finally {
      setState(() => _isLoading = false);
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
                  Text('Create your Zaika account',
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 25),

                  // Card UI
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
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
                          MyTextField(
                            controller: passwordController,
                            hintText: "Password",
                            obsecureText: !_isPasswordVisible,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () => setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              }),
                            ),
                          ),
                          const SizedBox(height: 15),
                          MyTextField(
                            controller: confirmPasswordController,
                            hintText: "Confirm Password",
                            obsecureText: !_isConfirmPasswordVisible,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isConfirmPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () => setState(() {
                                _isConfirmPasswordVisible =
                                    !_isConfirmPasswordVisible;
                              }),
                            ),
                          ),
                          const SizedBox(height: 20),
                          _isLoading
                              ? const CircularProgressIndicator()
                              : MyButton(onTap: register, text: "Sign Up"),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Already registered
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?',
                          style: Theme.of(context).textTheme.bodyMedium),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(' Login now...',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary)),
                      ),
                    ],
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
