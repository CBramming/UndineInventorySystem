import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Image.asset(
          'assets/Images/undinelogo_black-1-1.png', // Replace with the actual path to your image
          width: 230.0, // Adjust the width of the image
          height: 100.0, // Adjust the height of the image
          fit: BoxFit.contain, // Adjust the fit of the image
        ),
      ),
    );
  }
}