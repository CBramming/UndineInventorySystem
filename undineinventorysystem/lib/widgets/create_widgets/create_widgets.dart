import 'package:flutter/material.dart';

class CreateTitle extends StatelessWidget {
  const CreateTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Create',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
    );
  }
}

class NameInputField extends StatelessWidget {
  final TextEditingController controller;

  const NameInputField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    const Color borderColor = Color.fromARGB(255, 0, 0, 0);

    return TextFormField(
      controller: controller,
      cursorColor: borderColor,
      style: const TextStyle(color: borderColor),
      decoration: const InputDecoration(
        labelText: 'Name',
        labelStyle: TextStyle(
            color: borderColor, fontSize: 16, fontWeight: FontWeight.w500),
        suffixIcon: Icon(Icons.person_outline, color: borderColor),
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

class AmountInputField extends StatelessWidget {
  final TextEditingController controller;

  const AmountInputField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    const Color borderColor = Color.fromARGB(255, 0, 0, 0);

    return TextFormField(
      controller: controller,
      cursorColor: borderColor,
      style: const TextStyle(color: borderColor),
      decoration: const InputDecoration(
        labelText: 'Amount',
        labelStyle: TextStyle(
            color: borderColor, fontSize: 16, fontWeight: FontWeight.w500),
        suffixIcon: Icon(Icons.format_list_numbered, color: borderColor),
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

class DescriptionInputField extends StatelessWidget {
  final TextEditingController controller;

  const DescriptionInputField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    const Color borderColor = Color.fromARGB(255, 0, 0, 0);

    return TextFormField(
      controller: controller,
      cursorColor: borderColor,
      style: const TextStyle(color: borderColor),
      decoration: const InputDecoration(
        labelText: 'Decsription',
        labelStyle: TextStyle(
            color: borderColor, fontSize: 16, fontWeight: FontWeight.w500),
        suffixIcon: Icon(Icons.description, color: borderColor),
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

class TagInputField extends StatelessWidget {
  final TextEditingController controller;

  const TagInputField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    const Color borderColor = Color.fromARGB(255, 0, 0, 0);

    return TextFormField(
      controller: controller,
      cursorColor: borderColor,
      style: const TextStyle(color: borderColor),
      decoration: const InputDecoration(
        labelText: 'Tag',
        labelStyle: TextStyle(
            color: borderColor, fontSize: 16, fontWeight: FontWeight.w500),
        suffixIcon: Icon(Icons.tag, color: borderColor),
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

class CreateButton extends StatelessWidget {
  final VoidCallback onCreate;

  const CreateButton({super.key, required this.onCreate});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 50,
      child: ElevatedButton(
        onPressed: onCreate,
        style: ElevatedButton.styleFrom(
          elevation: 5,
          backgroundColor: const Color.fromARGB(218, 1, 15, 58),
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: const Text(
          'Create',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}

class CancelButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CancelButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 5,
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onPressed: onPressed,
        child: const Text(
          'Cancel',
          style: TextStyle(fontSize: 18, color: Color.fromARGB(218, 1, 15, 58)),
        ),
      ),
    );
  }
}
