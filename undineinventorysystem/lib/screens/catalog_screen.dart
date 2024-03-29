import 'dart:async';

import 'package:flutter/material.dart';
import 'package:undineinventorysystem/models/item.dart';
import 'package:undineinventorysystem/screens/create_screen.dart';
import 'package:undineinventorysystem/services/item_service.dart';
import 'package:undineinventorysystem/services/category_service.dart';
import 'package:undineinventorysystem/utils/error_handler.dart';
import 'package:undineinventorysystem/widgets/catalog_widgets/catalog_widgets.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  _CatalogScreenState createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final CategoryService categoryService = CategoryService();
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

  void _showCategoryList(BuildContext context) async {
    Map<String, dynamic> result = await categoryService.getAllCategories();

    if (result['error'] == UpdateError.none) {
      // ignore: use_build_context_synchronously
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        elevation: 5.0,
        builder: (BuildContext context) {
          List<String> categories = result['categories'];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.separated(
              itemCount: categories.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    categories[index],
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    onCategorySelected(context, categories[index]);
                  },
                );
              },
              separatorBuilder: (context, index) => const Divider(),
            ),
          );
        },
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error fetching categories')),
      );
    }
  }

  void onCategorySelected(BuildContext context, String categoryName) async {
    var categoryItemsResult =
        await categoryService.getItemsByCategory(categoryName);

    if (categoryItemsResult['error'] == UpdateError.none) {
      setState(() {
        itemsFuture = Future.value(categoryItemsResult['items']);
      });
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error fetching items for the category')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<Item>>(
      future: itemsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(Color.fromARGB(218, 1, 15, 58)),
              strokeWidth: 5,
              strokeAlign: 10,
            ),
          );
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No items found');
        }

        List<Item> filteredItems = _filterItems(_searchString, snapshot.data!);

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
            const SizedBox(height: 5),
            CategorySearchButton(
              onCategorySearch: () => _showCategoryList(context),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: CardGrid(
                searchString: _searchString,
                items: filteredItems,
                refreshCatalog: refreshItems,
              ),
            ),
            GoCreate(
              onGoCreate: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreateScreen()));
              },
            ),
          ],
        );
      },
    ));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
