import 'package:flutter/material.dart';

class DetailedViewTitel extends StatelessWidget{
  const DetailedViewTitel({super.key});

  @override
  Widget build(BuildContext context){
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
        backgroundColor: const Color.fromARGB(255, 68, 98, 122)
      ),
      onPressed: onPressed,
      child: const Text('-', style: TextStyle(color: Colors.white)),
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
        backgroundColor: const Color.fromARGB(255, 68, 98, 122)
      ),
      onPressed: onPressed,
      child: const Text('+', style: TextStyle(color: Colors.white)),
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
      style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 10, 240, 40)),
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
      style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 240, 10, 10)),
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




