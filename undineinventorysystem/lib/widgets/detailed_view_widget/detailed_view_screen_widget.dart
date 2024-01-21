import 'package:flutter/material.dart';
import 'package:undineinventorysystem/models/item.dart';
import 'package:undineinventorysystem/widgets/custom_widgets/expandable_text_widget.dart';
import 'package:undineinventorysystem/screens/detailed_view_screen.dart';

// Not used currently
class DetailedViewItemName extends StatelessWidget {
  final Item item;

  const DetailedViewItemName({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      item.name,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24,
        color: Colors.grey[800],
      ),
    );
  }
}

// Not used currently
class InputItem extends StatelessWidget {
  final TextEditingController inputItemsController;

  const InputItem({Key? key, required this.inputItemsController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: inputItemsController,
      decoration: InputDecoration(
        labelText: 'Update amount',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        isDense: true,
        contentPadding: const EdgeInsets.all(8),
      ),
    );
  }
}

class DecrementButton extends StatelessWidget {
  final VoidCallback onPressed;

  const DecrementButton(this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      ),
      child: const Icon(Icons.remove),
    );
  }
}

class IncrementButton extends StatelessWidget {
  final VoidCallback onPressed;

  const IncrementButton(this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      ),
      child: const Icon(Icons.add),
    );
  }
}

class PutButton extends StatelessWidget {
  final TextEditingController inputItemsController;
  final int counter;
  final void Function(String, int) onPressed;

  const PutButton({
    super.key,
    required this.inputItemsController,
    required this.counter,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 5,
          backgroundColor: const Color.fromARGB(218, 1, 15, 58),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () => onPressed(inputItemsController.text, counter),
        child: const Text(
          'Put',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

class TakeButton extends StatelessWidget {
  final TextEditingController deleteItemsController;
  final int counter;
  final void Function(String, int) onPressed;

  const TakeButton({
    super.key,
    required this.deleteItemsController,
    required this.counter,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 5,
          backgroundColor: Colors.white,
          foregroundColor: const Color.fromARGB(218, 1, 15, 58),
          side:
              const BorderSide(color: Color.fromARGB(218, 1, 15, 58), width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () => onPressed(deleteItemsController.text, counter),
        child: const Text('Take',
            style: TextStyle(
                fontSize: 18, color: Color.fromARGB(255, 10, 17, 40))),
      ),
    );
  }
}

class DetailedViewImage extends StatelessWidget {
  final Item item;

  const DetailedViewImage({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey[200],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: item.imageUrl != 'No Image'
                ? Image.network(
                    item.imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return const Icon(Icons.broken_image, size: 50);
                    },
                  )
                : const Icon(Icons.image_not_supported, size: 50),
          ),
        ),
      ),
    );
  }
}

// Not used currently
class ItemNameText extends StatelessWidget {
  final Item item;

  const ItemNameText({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      item.name,
      style: TextStyle(fontSize: 18, color: Colors.grey[600]),
    );
  }
}

// Not used currently
class ItemAmountText extends StatelessWidget {
  final Item item;
  const ItemAmountText({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Stock: ${item.amount}',
      textAlign: TextAlign.center,
    );
  }
}

// Not used currently - Would be used if the description should be a text field on Detailed Item View instead of the modal pop-up
class ItemDescriptionText extends StatelessWidget {
  final Item item;

  const ItemDescriptionText({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandableText(
      text: item.description,
      maxLines: 7,
    );
  }
}

class ItemDescriptionButton extends StatelessWidget {
  final Item item;

  const ItemDescriptionButton({Key? key, required this.item}) : super(key: key);

  void _showDescriptionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          title: const Text(
            'Item Description',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  item.description,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.grey[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close', style: TextStyle(color: Colors.blue)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => _showDescriptionDialog(context),
      style: TextButton.styleFrom(
        foregroundColor: Colors.blue,
        alignment: Alignment.centerLeft,
      ),
      // Adjust left padding as needed
      child: const Text(
        'Item Description',
        style: TextStyle(
          color: Colors.blue,
        ),
      ),
    );
  }
}

class GoBOM extends StatelessWidget {
  final VoidCallback onGoBOM;

  const GoBOM({Key? key, required this.onGoBOM}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onGoBOM,
    style: ElevatedButton.styleFrom(
          elevation: 5,
          backgroundColor: const Color.fromARGB(218, 1, 15, 58),
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: const Text(
          'Add to BOM',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      );
  }
} 



class CardGridForAnItem extends StatelessWidget {
  final Future<List<Item>> futureItems; // Updated to Future<List<Item>>

  const CardGridForAnItem({
    Key? key,
    required this.futureItems, // Pass the Future<List<Item>> as a parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Item>>(
      future: futureItems,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Item> items = snapshot.data ?? [];
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
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
}
