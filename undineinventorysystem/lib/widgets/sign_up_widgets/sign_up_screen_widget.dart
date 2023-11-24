import 'package:flutter/material.dart';

class SignUpPush extends StatelessWidget {
  final VoidCallback onSignUpPush;

  const SignUpPush({super.key, required this.onSignUpPush});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onSignUpPush,
      child: const Text('Signup'),
    );
  }
}

class SignUpTitle extends StatelessWidget {
  const SignUpTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'SignUp',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
    );
  }
}

class EmailInputField extends StatelessWidget {
  final TextEditingController controller;

  const EmailInputField({super.key, required this.controller});

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

class ConfirmationPasswordInputField extends StatelessWidget {
  final TextEditingController controller;

  const ConfirmationPasswordInputField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Confirm Password',
        suffixIcon: Icon(Icons.lock_outline),
      ),
      obscureText: true,
    );
  }
}

class AlreadyHaveAnAccount extends StatelessWidget{

  const AlreadyHaveAnAccount({super.key});

  @override
  Widget build(BuildContext context){
    return const Text(
      'Already have an account?',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 14),
    );
  }
}

class BackToLogin extends StatelessWidget{
  final VoidCallback onBackToLogin;

  const BackToLogin({super.key, required this.onBackToLogin});

  @override
  Widget build(BuildContext context){
    return TextButton(
      onPressed: onBackToLogin,
      child: const Text('Login'),
    );
  }
}