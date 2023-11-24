import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:undineinventorysystem/screens/qr_scanner_screen.dart';
import 'package:undineinventorysystem/screens/sign_up_screen.dart';
import '../widgets/login_widgets/login_screen_widgets.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatelessWidget {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 200),
              const LoginTitle(),
              const SizedBox(height: 48.0),
              UsernameInputField(controller: usernameController),
              const SizedBox(height: 16.0),
              PasswordInputField(controller: passwordController),
              const SizedBox(height: 80.0),
              LoginButton(
                onLogin: () => signIn(context),
              ),
              SignUpPrompt(
                onSignUpPrompt: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signIn(BuildContext context) async {
    String email = usernameController.text.trim();
    String password = passwordController.text.trim();

    print('Attempting to sign in with Email: $email'); // Debugging

    if (email.isEmpty || password.isEmpty) {
      print('Email or password is empty'); // Debugging
      // TODO: Handle empty fields, show an error message, etc.
      return;
    }

    try {
      User? user =
          await AuthService().signInWithEmailAndPassword(email, password);
      print('Firebase Auth Response User: $user'); // Debugging

      if (user != null) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const QRScannerScreen()));
      } else {
        print('User is null after sign in attempt'); // Debugging
        // TODO: Handle null user (not signed in), show an error message
      }
    } catch (e) {
      print('Sign in error: $e'); // Debugging
      // TODO: Handle the error, show error message
    }
  }
}
