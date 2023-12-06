import 'package:flutter/material.dart';

class ManuelGetItemTitel extends StatelessWidget {
  const ManuelGetItemTitel({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Manuel Get Item',
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
      decoration: const InputDecoration(
        labelText: 'Search for a specific item',
        suffixIcon: Icon(Icons.sailing),
      ),
    );
  }
}

class GetInputItem extends StatelessWidget {
  final TextEditingController getinputitemscontroller;
  final void Function(String) onPressed;

  const GetInputItem({super.key, 
    required this.getinputitemscontroller,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 68, 98, 122)),
        onPressed: () {
          // Call the onPressed function with the input data
          onPressed(getinputitemscontroller.text);
        },
        child: const Text('Get', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
