import 'package:flutter/material.dart';
import 'package:undineinventorysystem/widgets/Manuel_input_items_widget/manuel_input_items_screen_widget.dart';

class ManuelInputCounter extends StatefulWidget{
  const ManuelInputCounter({super.key});

  @override
    ManuelInputItems createState() => ManuelInputItems();
}

class ManuelInputItems extends State<ManuelInputCounter>{
  final inputitemscontroller = TextEditingController();


 int counter = 0;

   void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void decrementCounter() {
    setState(() {
      counter--;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:<Widget> [
              const SizedBox(height: 200.0),
              InputItem(inputitemscontroller: inputitemscontroller),
              const SizedBox(height: 10.0),
              Text(
                '$counter',
              )
            ],
          ),
        ),
      ),
    );
  }
}