import 'package:flutter/material.dart';
import 'package:undineinventorysystem/widgets/detailed_view_widget/detailed_view_screen_widget.dart';
import '../services/item_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailedItemCounter extends StatefulWidget {
  const DetailedItemCounter({Key? key}) : super(key: key);

  @override
  DetailedItemView createState() => DetailedItemView();
}

class DetailedItemView extends State<DetailedItemCounter> {
  final inputitemscontroller = TextEditingController();
  ItemService itemService = ItemService();

  int counter = 0;

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void decrementCounter() {
    setState(() {
      if (counter > 0) {
        counter--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: const <Widget>[
          ],
        ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const DetailedViewTitel(),
              const SizedBox(height: 65.0),
              const DetailedViewImage(),
              const SizedBox(height: 30.0),
              const DynamicTextStock(),
              const SizedBox(height: 5.0),
              const DynamicTextAmount(),
              const SizedBox(height: 5.0),
              const DynamicDescription(),
              const SizedBox(height: 20.0),

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
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  
                  SendInputItem(
                    inputitemscontroller: inputitemscontroller,
                    counter: counter,
                    onPressed: (String name, int count) {
                      itemService.addItemToDB(inputitemscontroller.text, counter);
                    },
                  ),
                  const SizedBox(width: 10),
                  DeleteInputItem(
                    deleteitemscontroller: inputitemscontroller,
                    counter: counter,
                    onPressed: (String name, int count) {
                      itemService.deleteItemToDB(inputitemscontroller.text, counter);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
