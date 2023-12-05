import 'package:flutter/material.dart';

class LoginTitle extends StatelessWidget {
  const LoginTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Login',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
    );
  }
}

class UsernameInputField extends StatelessWidget {
  final TextEditingController controller;

  const UsernameInputField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Email',
        suffixIcon: Icon(Icons.person_outline),
      ),
    );
  }
}

class PasswordInputField extends StatelessWidget {
  final TextEditingController controller;

  const PasswordInputField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Password',
        suffixIcon: Icon(Icons.lock_outline),
      ),
      obscureText: true,
    );
  }
}

class LoginButton extends StatelessWidget {
  final VoidCallback onLogin;

  const LoginButton({super.key, required this.onLogin});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 50,
      child: ElevatedButton(
        onPressed: onLogin,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 68, 98, 122),
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: const Text(
          'Login',
          style: TextStyle(fontSize: 18, color: Colors.white),
          
        ),
      ),
    );
  }
}

class SignUpPrompt extends StatelessWidget {
  final VoidCallback onSignUpPrompt;

  const SignUpPrompt({super.key, required this.onSignUpPrompt});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onSignUpPrompt,
      child: const Text('Sign up here'),
    );
  }
}
