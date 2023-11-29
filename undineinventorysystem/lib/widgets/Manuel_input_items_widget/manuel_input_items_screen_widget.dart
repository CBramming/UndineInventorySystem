import 'package:flutter/material.dart';

class InputItem extends StatelessWidget{
  final TextEditingController inputitemscontroller;

  const InputItem({super.key, required this.inputitemscontroller});
  @override
  Widget build(BuildContext context){
    return TextFormField(
      controller: inputitemscontroller,
    );
  }
}
class DecrementButton extends StatelessWidget{
  
}

class IncrementButton extends StatelessWidget{
  
}





