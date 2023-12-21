import 'package:flutter/material.dart';

class ManualGetItemTitle extends StatelessWidget {
  const ManualGetItemTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Manual Get Item',
      textAlign: TextAlign.center,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
    );
  }
}

class InputItem extends StatelessWidget {
  final TextEditingController inputItemsController;

  const InputItem({super.key, required this.inputItemsController});

  @override
  Widget build(BuildContext context) {
    const Color borderColor = Color.fromARGB(255, 0, 0, 0);

    return TextFormField(
      controller: inputItemsController,
      cursorColor: borderColor,
      style: const TextStyle(color: borderColor),
      decoration: const InputDecoration(
        labelText: 'Search for a specific item',
        labelStyle: TextStyle(
            color: borderColor, fontSize: 16, fontWeight: FontWeight.w500),
        suffixIcon: Icon(Icons.sailing_outlined, color: borderColor),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: borderColor,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: borderColor,
          ),
        ),
      ),
    );
  }
}

class GetInputItem extends StatelessWidget {
  final TextEditingController getInputitemsController;
  final void Function(String) onPressed;

  const GetInputItem({
    super.key,
    required this.getInputitemsController,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          onPressed(getInputitemsController.text);
        },
        style: ElevatedButton.styleFrom(
          elevation: 5,
          backgroundColor: const Color.fromARGB(218, 1, 15, 58),
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: const Text(
          'Get Item',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
