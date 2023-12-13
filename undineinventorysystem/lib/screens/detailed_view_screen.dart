import 'dart:async';
import 'package:flutter/material.dart';
import 'package:undineinventorysystem/models/item.dart';
import 'package:undineinventorysystem/widgets/detailed_view_widget/detailed_view_screen_widget.dart';
import '../services/item_service.dart';

class DetailedItemCounter extends StatefulWidget {
  final Item item;
  final Function(int) onAmountChanged;

  const DetailedItemCounter({
    Key? key,
    required this.item,
    required this.onAmountChanged,
  }) : super(key: key);

  @override
  _DetailedItemCounterState createState() => _DetailedItemCounterState();
}

class _DetailedItemCounterState extends State<DetailedItemCounter> {
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
        backgroundColor: Colors.white,
        elevation: 0,
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
              _buildAmountDisplay(),
              const SizedBox(height: 20.0),
              DynamicDescription(item: widget.item),
              const SizedBox(height: 20.0),
              _buildCounterRow(),
              const SizedBox(height: 30),
              _buildActionButtons(),
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
        DecrementButton(_decrementCounter),
        const SizedBox(width: 20.0),
        Text('$_counter'),
        const SizedBox(width: 20.0),
        IncrementButton(_incrementCounter),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SendInputItem(
          inputitemscontroller: _inputItemsController,
          counter: _counter,
          onPressed: (String name, int count) async {
            await _itemService.updateItemAddAmountInDB(
                widget.item.name, _counter);
            _updateAmount(_counter); // Update internal amount state
            _resetCounter();
          },
        ),
        const SizedBox(width: 10),
        DeleteInputItem(
          deleteitemscontroller: _inputItemsController,
          counter: _counter,
          onPressed: (String name, int count) async {
            await _itemService.updateItemReduceAmountInDB(
                widget.item.name, _counter);
            _updateAmount(-_counter); // Update internal amount state
            _resetCounter();
          },
        ),
      ],
    );
  }

  Widget _buildAmountDisplay() {
    return Text('Amount: $_currentAmount');
  }
}
