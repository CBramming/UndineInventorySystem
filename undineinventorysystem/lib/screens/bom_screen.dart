import 'package:flutter/material.dart';
import 'package:undineinventorysystem/models/item.dart';
import 'package:undineinventorysystem/widgets/bom_widgets/bom_widgets.dart';

class BOMScreen extends StatefulWidget {
  final Item item;

  const BOMScreen({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  BOMScreenState createState() => BOMScreenState();
}

class BOMScreenState extends State<BOMScreen> {
  final TextEditingController controller1 = TextEditingController();
  final List<String> itemList1 = ['Item 1', 'Item 2', 'Item 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.item.name}s Bill of Material',
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 350),
          
          ],
        ),
      ),
    );
  }
}
