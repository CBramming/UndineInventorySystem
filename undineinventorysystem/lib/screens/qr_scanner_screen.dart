import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:undineinventorysystem/models/item.dart';
import 'package:undineinventorysystem/screens/catalog_screen.dart';
import 'package:undineinventorysystem/screens/detailed_view_screen.dart';
import 'package:undineinventorysystem/screens/manual_get_item.dart';
import 'package:undineinventorysystem/services/item_service.dart';
import 'package:undineinventorysystem/utils/error_handler.dart';
import 'package:undineinventorysystem/widgets/custom_widgets/person_dropdown_menu_widget.dart';
import 'package:undineinventorysystem/widgets/qr_scanner_screen_widget/qr_scanner_widget.dart';

import 'package:undineinventorysystem/widgets/custom_widgets/tab_bar.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({Key? key}) : super(key: key);

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  QRViewController? controller;
  bool isNavigating = false;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void handleScanResult(Barcode result) async {
    if (!isNavigating && result.code != null) {
      setState(() {
        isNavigating = true;
      });

      controller?.pauseCamera();

      ItemService itemService = ItemService();
      var dbResult = await itemService.getItemFromDBNameField(result.code!);
      Item? item = dbResult['item'];
      UpdateError error = dbResult['error'];

      if (item != null) {
        // ignore: use_build_context_synchronously
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailedItemView(
              item: item,
              onAmountChanged: (_) {},
            ),
          ),
        );
      } else {
        ErrorHandler.handleError(error, context);
      }

      if (mounted) {
        setState(() {
          isNavigating = false;
        });
        controller?.resumeCamera();
      }
    } else {
      print('No result or isNavigating is true.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: const [PersonDropdownMenu()],
        ),
        body: TabBarView(
          children: [
            QRScannerWidget(
              onQRViewCreated: (QRViewController qrViewController) {
                setState(() {
                  controller = qrViewController;
                });
                qrViewController.scannedDataStream.listen((scanData) {
                  handleScanResult(scanData);
                });
              },
              onScanResult: handleScanResult,
            ),
            ManuelGetItem(),
            const CatalogScreen(),
          ],
        ),
        bottomNavigationBar: const CustomTabBar(),
      ),
    );
  }
}
