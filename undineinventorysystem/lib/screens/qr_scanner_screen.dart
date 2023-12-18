import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:undineinventorysystem/screens/catalog_screen.dart';
import 'package:undineinventorysystem/screens/manual_get_item.dart';
import 'package:undineinventorysystem/widgets/custom_widgets/person_dropdown_menu_widget.dart';
import 'package:undineinventorysystem/widgets/qr_scanner_screen_widget/qr_scanner_widget.dart';

import 'package:undineinventorysystem/widgets/custom_widgets/tab_bar.dart';

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
          actions: const <Widget>[
            PersonDropdownMenu(),
          ],
        ),
        body: TabBarView(
          children: [
            QRScannerWidget(onScanResult: handleScanResult),
            ManuelGetItem(),
            const CatalogScreen(),
          ],
        ),
        bottomNavigationBar: const CustomTabBar(),
      ),
    );
  }
}
