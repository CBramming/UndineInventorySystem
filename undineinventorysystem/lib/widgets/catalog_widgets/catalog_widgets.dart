import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:undineinventorysystem/models/item.dart';
import 'package:undineinventorysystem/screens/detailed_view_screen.dart';
import 'package:undineinventorysystem/services/item_service.dart';

class CardGrid extends StatelessWidget {
  final String searchString;
  final List<Item> filteredItems;
  final Function refreshCatalog;

  const CardGrid({
    super.key,
    required this.searchString,
    required this.filteredItems,
    required this.refreshCatalog,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Item>>(
      future: ItemService().getAllItems(),
      builder: (BuildContext context, AsyncSnapshot<List<Item>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CupertinoActivityIndicator(
            animating: true,
            radius: 20,
          );
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No items found');
        }

        List<Item> items = searchString.isEmpty
            ? snapshot.data!
            : snapshot.data!.where((item) {
                return item.name
                    .toLowerCase()
                    .contains(searchString.toLowerCase());
              }).toList();

        return buildGridView(items, context);
      },
    );
  }

  Widget buildGridView(List<Item> items, BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return buildCard(context, items[index]);
      },
    );
  }

  Widget buildCard(BuildContext context, Item item) {
    return InkWell(
        onTap: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DetailedItemView(
                item: item,
                onAmountChanged: (int) {},
              ),
            ),
          );
          refreshCatalog();
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: (item.imageUrl != 'No Image')
                    ? Image.network(
                        item.imageUrl,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        color: Colors.grey,
                        child: const Icon(Icons.image, size: 50),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text('x${item.amount}'),
                        Container(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Icon(
                            Icons.circle,
                            color: _getIconColor(item.amount),
                            size: 15.0,
                            // Set the desired color for the icon
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

Color _getIconColor(int amount) {
  if (amount >= 30) {
    return Colors.green;
  } else if (amount >= 15) {
    return Colors.yellow;
  } else {
    return Colors.red;
  }
}

class SearchBarWidget extends StatelessWidget {
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;

  const SearchBarWidget({
    super.key,
    required this.searchController,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6.0),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          labelText: 'Search item',
          labelStyle: TextStyle(
            color: Colors.grey[600],
          ),
          fillColor: Colors.white,
          filled: true,
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          suffixIcon: searchController.text.isNotEmpty
              ? GestureDetector(
                  onTap: () {
                    searchController.clear();
                    onSearchChanged('');
                  },
                  child: const Icon(Icons.clear, color: Colors.grey),
                )
              : null,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(4),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        onChanged: onSearchChanged,
      ),
    );
  }
}
