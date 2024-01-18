import 'dart:async';

import 'package:flutter/material.dart';
import 'package:undineinventorysystem/models/item.dart';
import 'package:undineinventorysystem/screens/create_screen.dart';
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
  List<Item> items = [];
  late Future<List<Item>> itemsFuture;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchString = _searchController.text;
      });
    });

    itemsFuture = _fetchItems();
  }

  Future<List<Item>> _fetchItems() async {
    try {
      var result = await ItemService().getAllItems();
      List<Item> items = List<Item>.from(result['items'] ?? []);
      return items;
    } catch (e) {
      return [];
    }
  }

  void refreshItems() {
    setState(() {
      itemsFuture = _fetchItems();
    });
  }

  List<Item> _filterItems(String searchString, List<Item> allItems) {
    searchString = searchString.toLowerCase();
    var filtered = allItems.where((item) {
      bool nameMatch = item.name.toLowerCase().contains(searchString);
      bool tagMatch =
          item.tags.any((tag) => tag.toLowerCase().contains(searchString));
      return nameMatch || tagMatch;
    }).toList();
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Item>>(
        future: itemsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('No items found');
          }

          List<Item> filteredItems =
              _filterItems(_searchString, snapshot.data!);

          return Column(
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
                  items: filteredItems,
                  refreshCatalog: refreshItems,
                ),
              ),
            ],
          );
        },
      body: Column(
        children: [
          GoCreate(
                onGoCreate: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CreateScreen()));
                },
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
