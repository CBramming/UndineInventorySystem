import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScannerTitle extends StatelessWidget {
  const QrScannerTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'QrScanner',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
    );
  }
}

class QrScannerButtonToManuelInputItems extends StatelessWidget {
  final VoidCallback onForwardToManuelInputItems;
  const QrScannerButtonToManuelInputItems(
      {super.key, required this.onForwardToManuelInputItems});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onForwardToManuelInputItems,
      child: const Text('Manuel input of items'),
    );
  }
}

class QRScannerWidget extends StatefulWidget {
  final Function(QRViewController) onQRViewCreated;
  final Function(Barcode) onScanResult;

  const QRScannerWidget({
    Key? key,
    required this.onQRViewCreated,
    required this.onScanResult,
  }) : super(key: key);

  @override
  State<QRScannerWidget> createState() => _QRScannerWidgetState();
}

class _QRScannerWidgetState extends State<QRScannerWidget> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: widget.onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.red,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: 300,
      ),
    );
  }
}
