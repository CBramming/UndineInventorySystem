import 'package:flutter/material.dart';
import 'package:undineinventorysystem/models/item.dart';
import 'package:undineinventorysystem/screens/detailed_view_screen.dart';
import 'package:undineinventorysystem/services/item_service.dart';
import 'package:undineinventorysystem/utils/alert_dialog_utils.dart';
import 'package:undineinventorysystem/utils/error_handler.dart';
import '../widgets/manual_get_item_widget/manuel_get_item_screen_widgets.dart';

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
              InputItem(inputItemsController: inputitemscontroller),
              const SizedBox(height: 60),
              GetInputItem(
                getInputitemsController: inputitemscontroller,
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
    if (nameId.isNotEmpty) {
      var result = await ItemService().getItemFromDB(nameId);
      Item? item = result['item'];
      UpdateError error = result['error'];

      if (item != null) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DetailedItemView(
            item: item,
            onAmountChanged: (int) {}, 
          ),
        ));
      } else {
        // Handle the error using the ErrorHandler
        ErrorHandler.handleError(error, context);
      }
    } else {
      // Handle empty input case
      AlertDialogUtils.showErrorAlertDialog(
        context,
        title: 'Empty Input',
        message: 'Please enter a valid item name.',
      );
    }
  }
}
