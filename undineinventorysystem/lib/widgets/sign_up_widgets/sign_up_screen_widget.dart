import 'package:flutter/material.dart';

class SignUpPush extends StatelessWidget {
  final VoidCallback onSignUpPush;

  const SignUpPush({super.key, required this.onSignUpPush});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 50,
      child: ElevatedButton(
        onPressed: onSignUpPush,
        style: ElevatedButton.styleFrom(
          elevation: 5,
          backgroundColor: const Color.fromARGB(218, 1, 15, 58),
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: const Text(
          'Signup',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
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

class ConfirmationPasswordInputField extends StatelessWidget {
  final TextEditingController controller;

  const ConfirmationPasswordInputField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    const Color borderColor = Color.fromARGB(255, 0, 0, 0);

    return TextFormField(
      controller: controller,
      cursorColor: borderColor,
      style: const TextStyle(color: borderColor),
      decoration: const InputDecoration(
        labelText: 'Confirm Password',
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

class AlreadyHaveAnAccount extends StatelessWidget {
  const AlreadyHaveAnAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Already have an account?',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
    );
  }
}

class BackToLogin extends StatelessWidget {
  final VoidCallback onBackToLogin;

  const BackToLogin({super.key, required this.onBackToLogin});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onBackToLogin,
      child: const Text(
        'Login',
        style: TextStyle(
          fontSize: 14,
          color: Color.fromARGB(255, 0, 102, 255),
        ),
      ),
    );
  }
}
