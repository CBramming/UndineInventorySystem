import 'package:flutter/material.dart';
import 'package:undineinventorysystem/widgets/catalog_widgets/catalog_widgets.dart';

class Catalog extends StatelessWidget {
  const Catalog({super.key});

  @override
  Widget build(BuildContext context) {
    try {
      return CardGrid();
    } catch (e) {
      // Log the error or handle it as needed
      print('Error in Catalog screen: $e');
      return Center(child: Text('An error occurred.'));
    }
  }
}
