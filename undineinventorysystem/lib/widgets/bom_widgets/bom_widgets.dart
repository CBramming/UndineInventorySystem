import 'package:flutter/material.dart';
import 'package:undineinventorysystem/models/item.dart';

class CardGridWithPopUp extends StatelessWidget {
  final String searchString;
  final List<Item> items;
  final Function refreshCatalog;

  const CardGridWithPopUp({
    Key? key,
    required this.searchString,
    required this.items,
    required this.refreshCatalog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      onTap: () {
        _showAmountInputDialog(context, item);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: AspectRatio(
                aspectRatio: 16 / 9,
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
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
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
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAmountInputDialog(BuildContext context, Item item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Amount'),
          content: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Amount'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Get the entered amount
                String enteredAmount = ''; // Use the TextEditingController to get the entered amount

                // Do something with the entered amount, e.g., update the item
                // You can replace the following line with the logic you need
                print('Entered amount: $enteredAmount for item: ${item.name}');

                Navigator.of(context).pop(); // Close the dialog
                refreshCatalog(); // Refresh the catalog as needed
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
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