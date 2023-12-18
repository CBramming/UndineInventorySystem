import 'package:flutter/material.dart';
import 'package:undineinventorysystem/models/item.dart';
import 'package:undineinventorysystem/widgets/custom_widgets/expandable_text_widget.dart';

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
          backgroundColor: const Color.fromARGB(255, 21, 36, 82),
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
          backgroundColor: Colors.white,
          foregroundColor: const Color.fromARGB(255, 10, 17, 40),
          side: const BorderSide(
              color: Color.fromARGB(255, 10, 17, 40), width: 2),
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

class WannaDeleteItemDialog extends StatelessWidget {
  const WannaDeleteItemDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Sure you wanna delete this item?',
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        Align(
          alignment: Alignment.center,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 255, 0, 0),
            ),
            child: const Text('Yes, delete item'),
          ),
        ),
      ],
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
      ),
      child: const Text(
        'Item Description',
        style: TextStyle(
          color: Colors.blue,
        ),
      ),
    );
  }
}
