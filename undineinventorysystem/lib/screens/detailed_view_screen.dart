import 'dart:async';
import 'package:flutter/material.dart';
import 'package:undineinventorysystem/models/item.dart';
import 'package:undineinventorysystem/screens/bom_screen.dart';
import 'package:undineinventorysystem/utils/error_handler.dart';
import 'package:undineinventorysystem/widgets/detailed_view_widget/detailed_view_screen_widget.dart';
import '../services/item_service.dart';

class DetailedItemView extends StatefulWidget {
  final Item item;
  final Function(int) onAmountChanged;

  const DetailedItemView({
    Key? key,
    required this.item,
    required this.onAmountChanged,
  }) : super(key: key);

  @override
  _DetailedItemViewState createState() => _DetailedItemViewState();
}

class _DetailedItemViewState extends State<DetailedItemView> {
  final ItemService _itemService = ItemService();
  final TextEditingController _inputItemsController = TextEditingController();
  final StreamController<void> _updateStreamController =
      StreamController<void>.broadcast();
  int _counter = 0;
  late int _currentAmount;

  @override
  void initState() {
    super.initState();
    _currentAmount = widget.item.amount;
  }

  @override
  void dispose() {
    _updateStreamController.close();
    _inputItemsController.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    if (_counter > 0) {
      setState(() {
        _counter--;
      });
    }
  }

  void _updateAmount(int change) {
    setState(() {
      _currentAmount += change;
      widget.item.amount = _currentAmount;
    });
  }

  void _resetCounter() {
    setState(() => _counter = 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.item.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black87,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              DetailedViewImage(item: widget.item),
              const SizedBox(height: 20.0),
              ItemDescriptionButton(item: widget.item),
              const SizedBox(height: 20.0),
              Container(
                padding: const EdgeInsets.only(
                    left: 8.0), // Adjust the left padding as needed
                child: Text(
                  'Stock: ${widget.item.amount}',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [_buildCounterRow()]),
              const SizedBox(height: 20.0),
              _buildActionButtons(),
              const SizedBox(height: 30),
              Center(
                child: GoBOM(
                  onGoBOM: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  BOMScreen(item: widget.item),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCounterRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _counter > 0
            ? DecrementButton(_decrementCounter)
            : const SizedBox(width: 48, height: 48),
        const SizedBox(width: 20.0),
        Text('$_counter', style: const TextStyle(fontSize: 24)),
        const SizedBox(width: 20.0),
        IncrementButton(_incrementCounter),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TakeButton(
          deleteItemsController: _inputItemsController,
          counter: _counter,
          onPressed: (String name, int count) async {
            Map<String, dynamic> updateResult =
                await _itemService.updateItemReduceAmountInDB(
                    widget.item.name, _counter, context);
            bool updateSuccessful = updateResult['success'];

            if (updateSuccessful) {
              _updateAmount(-_counter);
            } else {
              UpdateError error = updateResult['error'];
              ErrorHandler.handleError(
                  error, context); // Handle errors using the ErrorHandler class
            }
            _resetCounter();
          },
        ),
        const SizedBox(width: 10),
        PutButton(
          inputItemsController: _inputItemsController,
          counter: _counter,
          onPressed: (String name, int count) async {
            Map<String, dynamic> addResult = await _itemService
                .updateItemAddAmountInDB(widget.item.name, _counter);
            if (!addResult['success']) {
              UpdateError error = addResult['error'];
              ErrorHandler.handleError(
                  error, context); // Handle errors for adding amount
            } else {
              _updateAmount(_counter);
            }
            _resetCounter();
          },
        ),
      ],
    );
  }
}
