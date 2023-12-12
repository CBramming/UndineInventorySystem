import 'package:flutter/material.dart';
import 'package:undineinventorysystem/models/item.dart';
import 'package:undineinventorysystem/widgets/detailed_view_widget/detailed_view_screen_widget.dart';
import '../services/item_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class DetailedItemCounter extends StatefulWidget {
  final Item item;

  DetailedItemCounter({Key? key, required this.item}) : super(key: key);

  @override
  _DetailedItemCounterState createState() => _DetailedItemCounterState();
}

class _DetailedItemCounterState extends State<DetailedItemCounter> {
  final ItemService itemService = ItemService();
  TextEditingController inputitemscontroller = TextEditingController();
  int counter = 0;

  // Define the stream controller before using it
  late StreamController<void> _updateStreamController;

  @override
  void initState() {
    super.initState();
    _updateStreamController = StreamController<void>.broadcast();
  }

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

  void resetCounter() {
    setState(() {
      counter = 0;
    });
  }

  @override
  void dispose() {
    _updateStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: const <Widget>[],
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
              DynamicTextStock(item: widget.item),
              const SizedBox(height: 5.0),
              StreamBuilder<void>(
                stream: _updateStreamController.stream,
                builder: (context, snapshot) {
                  return DynamicTextAmount(item: widget.item);
                },
              ),
              const SizedBox(height: 5.0),
              DynamicDescription(item: widget.item),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DecrementButton(() => decrementCounter()),
                  const SizedBox(width: 20.0),
                  Text('$counter'),
                  const SizedBox(width: 20.0),
                  IncrementButton(() => incrementCounter()),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SendInputItem(
                    inputitemscontroller: inputitemscontroller,
                    counter: counter,
                    onPressed: (String name, int count) async {
                      await itemService.updateItemAddAmountInDB(widget.item.name, counter);
                      resetCounter();
                      _updateStreamController.add(null);
                    },
                  ),
                  const SizedBox(width: 10),
                  DeleteInputItem(
                    deleteitemscontroller: inputitemscontroller,
                    counter: counter,
                    onPressed: (String name, int count) async {
                      await itemService.updateItemReduceAmountInDB(widget.item.name, counter);
                      resetCounter();
                      _updateStreamController.add(null);
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
