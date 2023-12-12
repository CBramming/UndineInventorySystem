import 'package:flutter/material.dart';
import 'package:undineinventorysystem/models/item.dart';

class DetailedViewTitel extends StatelessWidget {
  const DetailedViewTitel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Detailed View',
      textAlign: TextAlign.center,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
    );
  }
}

class InputItem extends StatelessWidget {
  final TextEditingController inputitemscontroller;

  const InputItem({super.key, required this.inputitemscontroller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: inputitemscontroller,
    );
  }
}

class DecrementButton extends StatelessWidget {
  final Function() onPressed;

  DecrementButton(this.onPressed);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 68, 98, 122),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(200))),
          onPressed: onPressed, 
            child: const Text('-',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center),
          ),
    );
  }
}

class IncrementButton extends StatelessWidget {
  final Function() onPressed;

  IncrementButton(this.onPressed);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 68, 98, 122),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(200))),
          onPressed: onPressed,
            child: const Text('+',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center),
          ),
    );
  }
}

class SendInputItem extends StatelessWidget {
  final TextEditingController inputitemscontroller;
  final int counter;
  final void Function(String, int) onPressed;

  SendInputItem({
    required this.inputitemscontroller,
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
            backgroundColor: const Color.fromARGB(255, 10, 240, 40)),
        onPressed: () {
          // Call the onPressed function with the input data
          onPressed(inputitemscontroller.text, counter);
        },
        child: const Text('Put', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class DeleteInputItem extends StatelessWidget {
  final TextEditingController deleteitemscontroller;
  final int counter;
  final void Function(String, int) onPressed;

  DeleteInputItem({
    required this.deleteitemscontroller,
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
            backgroundColor: const Color.fromARGB(255, 240, 10, 10)),
        onPressed: () {
          // Call the onPressed function with the input data
          onPressed(deleteitemscontroller.text, counter);
        },
        child: const Text('Take', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class DetailedViewImage extends StatelessWidget {
  const DetailedViewImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 300,
      height: 300,
      child: Image(image: AssetImage('assets/Images/hæksehyl.jpg')),
    );
  }
}

class DynamicTextStock extends StatelessWidget {
  final Item item;

  const DynamicTextStock({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Name: ${item.name}',
      textAlign: TextAlign.center,
    );
  }
}

class DynamicTextAmount extends StatelessWidget {
  final Item item;
  const DynamicTextAmount({Key? key, required this.item}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return Text(
      'Amount: ${item.amount}',
      textAlign: TextAlign.center,
    );
  }
}

class DynamicDescription extends StatelessWidget {
  const DynamicDescription({Key? key, required this.item}) : super(key: key);
  final Item item;
  @override
  Widget build(BuildContext context) {
    return Text(
      'Description: ${item.description}',
      textAlign: TextAlign.center,
    );
  }
}