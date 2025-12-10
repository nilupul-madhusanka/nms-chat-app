import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        // User cancelled the sign-in
        return;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the credential
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Check if user exists in Firestore, if not create a new document
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      if (!userDoc.exists) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'userId': userCredential.user!.uid,
          'username': userCredential.user!.displayName ?? 'Google User',
          'email': userCredential.user!.email,
        });
      }

      if (!context.mounted) return;
      Navigator.pushReplacementNamed(context, '/home');
    } catch (error) {
      debugPrint('Error signing in with Google: $error');
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
              const SizedBox(height: 30),
              const Row(
                children: [
                  Expanded(child: Divider(color: Colors.white54, thickness: 1)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text('OR', style: TextStyle(color: Colors.white)),
                  ),
                  Expanded(child: Divider(color: Colors.white54, thickness: 1)),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () => signInWithGoogle(context),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.white),
                  padding: WidgetStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
                icon: Image.network(
                  'https://www.google.com/favicon.ico',
                  height: 24,
                  width: 24,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.g_mobiledata,
                      color: Colors.red,
                      size: 24),
                ),
                label: const Text(
                  'Sign in with Google',
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
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
