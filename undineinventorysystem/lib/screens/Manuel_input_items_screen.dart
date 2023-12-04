import 'package:flutter/material.dart';
import 'package:undineinventorysystem/widgets/Manuel_input_items_widget/manuel_input_items_screen_widget.dart';
import '../services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManuelInputCounter extends StatefulWidget {
  const ManuelInputCounter({super.key});

  @override
  ManuelInputItems createState() => ManuelInputItems();
}

class ManuelInputItems extends State<ManuelInputCounter> {
  final inputitemscontroller = TextEditingController();
  AuthService authService = AuthService();

  int counter = 0;

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void decrementCounter() {
    setState(() {
      if(counter > 0){
        counter--;
      }      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 300.0),
              InputItem(inputitemscontroller: inputitemscontroller),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DecrementButton(decrementCounter),
                  const SizedBox(width: 20.0),
                  Text(
                    '$counter',
                  ),
                  const SizedBox(width: 20.0),
                  IncrementButton(incrementCounter),
                ],
              ),
              const SizedBox(height: 50),
             SendInputItem(
              inputitemscontroller: inputitemscontroller,
              counter: counter,
              onPressed: (String name, int count) {
                AuthService.addItemToDB(inputitemscontroller.text, counter);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}