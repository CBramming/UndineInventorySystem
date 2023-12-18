import 'package:flutter/material.dart';
import 'package:undineinventorysystem/models/item.dart';
import 'package:undineinventorysystem/screens/detailed_view_screen.dart';
import 'package:undineinventorysystem/services/item_service.dart';
import '../widgets/manuel_get_item_widget/manuel_get_item_screen_widgets.dart';

class ManuelGetItem extends StatelessWidget {
  ManuelGetItem({super.key});

  final inputitemscontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 200),
              const ManualGetItemTitle(),
              const SizedBox(height: 50),
              InputItem(inputitemscontroller: inputitemscontroller),
              const SizedBox(height: 130),
              GetInputItem(
                getinputitemscontroller: inputitemscontroller,
                onPressed: (String name) {
                  getItem(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getItem(BuildContext context) async {
    String nameId = inputitemscontroller.text.trim();
    try {
      Item? item = (await ItemService().getItemFromDB(nameId));
      if (nameId.isNotEmpty && item != null) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DetailedItemView(item: item, onAmountChanged: (int ) {  },),
        ));
      } else {
        print('Item Not Found');
      }
    } catch (e) {
      print('Error fetching item: $e');
    }
  }
}
