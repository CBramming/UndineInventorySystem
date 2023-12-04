import 'package:flutter/material.dart';
import 'package:undineinventorysystem/screens/manuel_input_items_screen.dart';
import 'package:undineinventorysystem/widgets/custom_widgets/person_dropdown_menu_widget.dart';
import 'package:undineinventorysystem/widgets/custom_widgets/tab_bar.dart';

class QRScannerScreen extends StatelessWidget {
  const QRScannerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: const <Widget>[
            PersonDropdownMenu(),
          ],
        ),
        body: const TabBarView(
          children: [
            Center(child: Text('QR Scanner Content')),
            ManuelInputCounter(),
            Center(child: Text('Catalog Content')),
          ],
        ),
        bottomNavigationBar: const CustomTabBar(),
      ),
    );
  }
}
