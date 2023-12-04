import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:undineinventorysystem/screens/Manuel_input_items_screen.dart';
import 'package:undineinventorysystem/screens/login_screen.dart';
import 'package:undineinventorysystem/widgets/qr_scanner_screen_widget/qr_scanner_widget.dart';

class QRScannerScreen extends StatelessWidget {
  const QRScannerScreen({Key? key}) : super(key: key);

  void handleScanResult(Barcode? result) {
    // Handle the result as needed
    if (result != null) {
      // Do something with the scanned result
      print('Scanned result: ${result.code}');
    } else {
      // Handle no result
      print('No result');
    }
  }

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            QRScannerWidget(onScanResult: handleScanResult),
            const SizedBox(height: 20), // Adjust the height as needed
            ElevatedButton(
              onPressed: () {
                // Handle the onPressed logic for the "Process Result" button
              },
              child: const Text('Process Result'),
            ),
            const SizedBox(height: 20), // Add additional spacing if necessary
            QrScannerButtonToManuelInputItems(
              onForwardToManuelInputItems: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ManuelInputCounter()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


