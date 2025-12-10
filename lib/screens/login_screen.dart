import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  Future<void> loginUser(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      if (!context.mounted) return;
      Navigator.pushReplacementNamed(context, '/home');
    } catch (error) {
      debugPrint('Error logging in: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text('Login',
                style: TextStyle(fontSize: 30, color: Colors.white))),
        backgroundColor: const Color(0xFF83427D),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.admin_panel_settings,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/contact');
            },
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                  style: const TextStyle(color: Colors.white),
                  controller: emailController,
                  decoration: const InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.amber))),
              TextField(
                  style: const TextStyle(color: Colors.white),
                  controller: passwordController,
                  decoration: const InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.amber)),
                  obscureText: true),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => registerUser(context),
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(const Color(0xFF008EC3))),
                    child: const Text(
                      'Register Here',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () => loginUser(context),
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(const Color(0xFF008EC3))),
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  registerUser(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/register');
  }
}
