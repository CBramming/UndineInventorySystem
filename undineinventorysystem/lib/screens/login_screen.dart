import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:undineinventorysystem/screens/qr_scanner_screen.dart';
import 'package:undineinventorysystem/screens/sign_up_screen.dart';
import 'package:undineinventorysystem/widgets/custom_widgets/logo_widget.dart';
import 'package:undineinventorysystem/utils/alert_dialog_utils.dart';
import '../widgets/login_widgets/login_screen_widgets.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
              const LogoWidget(),
              const SizedBox(height: 48.0),
              UsernameInputField(controller: emailController),
              const SizedBox(height: 16.0),
              PasswordInputField(controller: passwordController),
              const SizedBox(height: 50.0),
              LoginButton(
                onLogin: () => signIn(context),
              ),
              const SizedBox(height: 150.0),
              SignUpPrompt(
                onSignUpPrompt: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SignUpScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signIn(BuildContext context) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      AlertDialogUtils.showErrorAlertDialog(
        context,
        title: 'Error',
        message: 'Email or password cannot be empty',
      );
      return;
    }

    try {
      User? user =
          await AuthService().signInWithEmailAndPassword(email, password);

      if (!mounted) return;

      if (user != null) {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const QRScannerScreen()));
      } else {
        AlertDialogUtils.showErrorAlertDialog(
          context,
          title: 'Login Failed',
          message: 'Wrong email or password. Please try again.',
        );
        emailController.clear();
        passwordController.clear();
      }
    } catch (e) {
      if (!mounted) return;

      AlertDialogUtils.showErrorAlertDialog(
        context,
        title: 'Sign In Error',
        message: 'An error occurred during sign in. Please try again later.',
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
