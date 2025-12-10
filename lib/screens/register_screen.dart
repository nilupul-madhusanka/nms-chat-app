import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  RegisterScreen({super.key});

  Future<void> registerUser(BuildContext context) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'userId': userCredential.user!.uid,
        'username': usernameController.text.trim(),
        'email': emailController.text.trim(),
      });

      if (!context.mounted) return;
      Navigator.pushReplacementNamed(context, '/login');
    } catch (error) {
      debugPrint('Error registering user: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text('Register',
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
                  controller: usernameController,
                  decoration: const InputDecoration(
                      labelText: 'Username',
                      labelStyle: TextStyle(color: Colors.amber))),
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
                    onPressed: () => loginUser(context),
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(const Color(0xFF008EC3))),
                    child: const Text(
                      'Login Here',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () => registerUser(context),
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(const Color(0xFF008EC3))),
                    child: const Text(
                      'Register',
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

  loginUser(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/login');
  }
}
