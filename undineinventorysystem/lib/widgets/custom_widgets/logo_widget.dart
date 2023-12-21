import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Image.asset(
          'assets/Images/undinelogo_black-1-1.png',
          width: 230.0,
          height: 100.0,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}