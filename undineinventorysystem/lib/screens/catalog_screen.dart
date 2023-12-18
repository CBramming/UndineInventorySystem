import 'package:flutter/material.dart';
import 'package:undineinventorysystem/widgets/catalog_widgets/catalog_widgets.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  _CatalogScreenState createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchString = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchString = _searchController.text;
      });
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
              filteredItems: const [],
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
