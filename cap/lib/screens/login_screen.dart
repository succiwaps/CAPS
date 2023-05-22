import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // TODO: Implement login logic
            Navigator.pushNamed(context, '/admin_dashboard');
          },
          child: const Text('Login'),
        ),
      ),
    );
  }
}
