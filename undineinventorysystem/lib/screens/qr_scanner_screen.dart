import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:undineinventorysystem/models/item.dart';
import 'package:undineinventorysystem/screens/catalog_screen.dart';
import 'package:undineinventorysystem/screens/detailed_view_screen.dart';
import 'package:undineinventorysystem/screens/manual_get_item.dart';
import 'package:undineinventorysystem/services/item_service.dart';
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
    print('handleScanResult called with: ${result.code}'); // Debug print

    if (!isNavigating && result.code != null) {
      setState(() {
        isNavigating = true;
      });

      controller?.pauseCamera();
      print('Scanned result: ${result.code}');

      ItemService itemService = ItemService();
      Item? item = await itemService.getItemFromDB(result.code!);

      if (item != null) {
        print('Item found, navigating to detailed view.'); // Debug print
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
        print('Item not found in database.'); // Debug print
      }

      if (mounted) {
        setState(() {
          isNavigating = false;
        });
        controller?.resumeCamera();
      }
    } else {
      print('No result or isNavigating is true.'); // Debug print
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
