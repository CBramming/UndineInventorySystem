import 'dart:async';

import 'package:flutter/material.dart';
import 'package:undineinventorysystem/models/item.dart';
import 'package:undineinventorysystem/services/item_service.dart';
import 'package:undineinventorysystem/widgets/catalog_widgets/catalog_widgets.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  _CatalogScreenState createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchString = '';
  late Future<Map<String, dynamic>> itemsFuture;
  List<Item> items = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchString = _searchController.text;
      });
    });

    itemsFuture = ItemService().getAllItems();
  }

  void refreshItems() {
    setState(() {
      itemsFuture = ItemService().getAllItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SearchBarWidget(
            searchController: _searchController,
            onSearchChanged: (searchText) {
              setState(() {
                _searchString = searchText;
              });
            },
          ),
          Expanded(
            child: CardGrid(
              searchString: _searchString,
              filteredItems: items
                  .where((item) => item.name.contains(_searchString))
                  .toList(),
              refreshCatalog: refreshItems,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
