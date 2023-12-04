import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

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


class QRScannerWidget extends StatefulWidget {
  final Function(Barcode? result) onScanResult;

  const QRScannerWidget({Key? key, required this.onScanResult}) : super(key: key);

  @override
  _QRScannerWidgetState createState() => _QRScannerWidgetState();
}

class _QRScannerWidgetState extends State<QRScannerWidget> {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (controller != null && Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller?.resumeCamera();
  }

 @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          // ... Rest of the UI code from the example
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.red,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        widget.onScanResult(scanData); // Pass the result to the parent widget
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

