import 'package:flutter/material.dart';
import 'package:undineinventorysystem/screens/Manuel_input_items_screen.dart';
import 'package:undineinventorysystem/screens/login_screen.dart';
import 'package:undineinventorysystem/widgets/qr_scanner_screen_widget/qr_scanner_widget.dart';

class QRScannerScreen extends StatelessWidget {
  const QRScannerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Scanner'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, MaterialPageRoute(builder: (context) => LoginScreen()));
          },
        ),
      ),
      body: Center(
        child: 
        QrScannerButtonToManuelInputItems(
          onForwardToManuelInputItems: () {
            Navigator.push(context, 
            MaterialPageRoute(builder: (context) => const ManuelInputCounter()));
          },
        ),
      ),
    );
  }
}
