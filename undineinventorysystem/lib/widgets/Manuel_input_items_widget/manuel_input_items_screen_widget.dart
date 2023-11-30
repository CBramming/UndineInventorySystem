import 'package:flutter/material.dart';

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
    return ElevatedButton(
      onPressed: onPressed,
      child: Text('Decrement'),
    );
  }
}

class IncrementButton extends StatelessWidget {
  final Function() onPressed;

  IncrementButton(this.onPressed);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text('Increment'),
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
    return ElevatedButton(
      onPressed: () {
        // Call the onPressed function with the input data
        onPressed(inputitemscontroller.text, counter);
      },
      child: Text('Send Input Of Item'),
    );
  }
}





