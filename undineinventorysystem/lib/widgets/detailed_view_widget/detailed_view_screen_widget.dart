import 'package:flutter/material.dart';
import 'package:undineinventorysystem/models/item.dart';

class DetailedViewItemName extends StatelessWidget {
  final Item item;

  DetailedViewItemName({Key? key, required this.item}) : super(key: key);

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
        isDense: true, // Added for better control on the field's height
        contentPadding:
            const EdgeInsets.all(8), // Inner padding for the text field
      ),
    );
  }
}

class DecrementButton extends StatelessWidget {
  final Function() onPressed;

  DecrementButton(this.onPressed);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Colors.red[400],
      elevation: 2,
      child: const Icon(Icons.remove, color: Colors.white),
    );
  }
}

class IncrementButton extends StatelessWidget {
  final Function() onPressed;

  IncrementButton(this.onPressed);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Colors.green[400],
      elevation: 2,
      child: const Icon(Icons.add, color: Colors.white),
    );
  }
}

class SendInputItem extends StatelessWidget {
  final TextEditingController inputItemsController;
  final int counter;
  final void Function(String, int) onPressed;

  SendInputItem({
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
          backgroundColor: Color.fromARGB(255, 10, 17, 40), // darkish blue
          foregroundColor: Colors.white, // text color
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

class DeleteInputItem extends StatelessWidget {
  final TextEditingController deleteItemsController;
  final int counter;
  final void Function(String, int) onPressed;

  DeleteInputItem({
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
          backgroundColor: Colors.white, // button color
          foregroundColor: const Color.fromARGB(255, 10, 17, 40), // text color
          side: const BorderSide(
              color: Color.fromARGB(255, 10, 17, 40), width: 2), // border color
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
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: item.imageUrl != 'No Image'
          ? Image.network(item.imageUrl, fit: BoxFit.contain)
          : Container(
              color: Colors.grey[200],
              child: const Icon(Icons.image_not_supported, size: 50),
            ),
    );
  }
}

class TextItemName extends StatelessWidget {
  final Item item;

  const TextItemName({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      item.name,
      style: TextStyle(fontSize: 18, color: Colors.grey[600]),
    );
  }
}

class TextItemAmount extends StatelessWidget {
  final Item item;
  const TextItemAmount({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Stock: ${item.amount}',
      textAlign: TextAlign.center,
    );
  }
}

class TextItemDescription extends StatelessWidget {
  const TextItemDescription({Key? key, required this.item}) : super(key: key);
  final Item item;
  @override
  Widget build(BuildContext context) {
    return Text(
      item.description,
      style: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey[800]),
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
            onPressed: () {
              
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 255, 0, 0),
            ),
            child: const Text('Yes, delete item'),
          ),
        ),
      ],
    );
  }
}
