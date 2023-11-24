import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:undineinventorysystem/screens/login_screen.dart';
import 'package:undineinventorysystem/screens/qr_scanner_screen.dart';
import 'package:undineinventorysystem/services/auth_service.dart';
import 'package:undineinventorysystem/widgets/sign_up_widgets/sign_up_screen_widget.dart';

class SignUp extends StatelessWidget{
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmationPasswordController = TextEditingController();

    SignUp({super.key});

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
              const SizedBox(height: 150.0),
              const SignUpTitle(),
              const SizedBox(height: 48.0),
              EmailInputField(controller: emailController),
              const SizedBox(height: 16.0),
              PasswordInputField(controller: passwordController),
              const SizedBox(height: 16.0),
              ConfirmationPasswordInputField(controller: confirmationPasswordController),
              const SizedBox(height: 50.0),
              SignUpPush(onSignUpPush: () => signUp(context)),
              const SizedBox(height: 150.0),
              const AlreadyHaveAnAccount(),
              const SizedBox(height: 5.0),
              BackToLogin(
                onBackToLogin: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context) => LoginScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  void signUp(BuildContext context) async{
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmationPasswordController.text.trim();

      if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      print('Email or password is empty'); // Debugging
      // TODO: Handle empty fields, show an error message, etc.
      return;
    }

    if(confirmPassword != password){
      print('Passwords doesnt match');
    }

    try {
      User? user = await AuthService().createUserWithEmailAndPassword(email,password);
      if(user != null){
      Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const QRScannerScreen()));
      }
    } catch (e) {
      //Todo error handling
    }

  }
}
 