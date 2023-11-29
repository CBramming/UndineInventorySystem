import 'package:flutter/material.dart';

class QrScannerTitle extends StatelessWidget{

const QrScannerTitle({super.key});

  @override
  Widget build(BuildContext context){
    return const Text(
      'QrScanner',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
    );
  }
}

class QrScannerButtonToManuelInputItems extends StatelessWidget{
  final VoidCallback onForwardToManuelInputItems;
  const QrScannerButtonToManuelInputItems({super.key, required this.onForwardToManuelInputItems});

  @override
  Widget build(BuildContext context){
    return ElevatedButton(
      onPressed: onForwardToManuelInputItems,
      child: const Text(
        'Manuel input of items'
      ),
    
    );
  }
}