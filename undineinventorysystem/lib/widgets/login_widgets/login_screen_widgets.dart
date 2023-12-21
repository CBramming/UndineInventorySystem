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

class EmailInputField extends StatelessWidget {
  final TextEditingController controller;

  const EmailInputField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    const Color borderColor = Color.fromARGB(255, 0, 0, 0);

    return TextFormField(
      controller: controller,
      cursorColor: borderColor,
      style: const TextStyle(color: borderColor),
      decoration: const InputDecoration(
        labelText: 'Email',
        labelStyle: TextStyle(
            color: borderColor, fontSize: 16, fontWeight: FontWeight.w500),
        suffixIcon: Icon(Icons.person_outline, color: borderColor),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: borderColor,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: borderColor,
          ),
        ),
      ),
    );
  }
}

class PasswordInputField extends StatelessWidget {
  final TextEditingController controller;

  const PasswordInputField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    const Color borderColor = Color.fromARGB(255, 0, 0, 0);

    return TextFormField(
      controller: controller,
      cursorColor: borderColor,
      style: const TextStyle(color: borderColor),
      decoration: const InputDecoration(
        labelText: 'Password',
        labelStyle: TextStyle(
            color: borderColor, fontSize: 16, fontWeight: FontWeight.w500),
        suffixIcon: Icon(Icons.lock_outline, color: borderColor),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: borderColor,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: borderColor,
          ),
        ),
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
          elevation: 5,
          backgroundColor: const Color.fromARGB(218, 1, 15, 58),
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
      child: const Text('Sign up here',
          style:
              TextStyle(color: Color.fromARGB(255, 0, 102, 255), fontSize: 14)),
    );
  }
}
