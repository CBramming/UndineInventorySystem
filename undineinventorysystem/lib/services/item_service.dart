import 'dart:ffi';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:undineinventorysystem/models/item.dart';
import 'package:undineinventorysystem/models/recipe.dart';
import 'package:undineinventorysystem/utils/alert_dialog_utils.dart';
import 'package:undineinventorysystem/utils/error_handler.dart';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:undineinventorysystem/widgets/detailed_view_widget/detailed_view_screen_widget.dart';


class ItemService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final StreamController<void> _updateStreamController =
      StreamController<void>.broadcast();

  Stream<void> get updateStream => _updateStreamController.stream;

  Future<void> createItemToDB(String nameId, int amount, String description,
      String tag, File imageUrl) async {
    try {
      // Check if nameId and amount are provided
      if (nameId.isEmpty || amount <= 0) {
        throw 'Name and amount are required';
      }

      CollectionReference items = firestore.collection('Items');

      // Check if an item with the same name already exists
      var item = await items.where('Name', isEqualTo: nameId).get();
      if (item.docs.isNotEmpty) {
        throw 'Item with the same name already exists';
      }

      // Upload the image to Firebase Storage and get the download URL
      String downloadUrl = await uploadImageToStorage(imageUrl);

      // Store the download URL in the Firestore database
      await items.add({
        'Name': nameId,
        'Amount': amount,
        'Description': description,
        'tags': tag,
        'imageUrl': downloadUrl,
      });
    } catch (e) {
      print('Error creating item: $e');
      throw e;
    }
  }

  Future<String> uploadImageToStorage(File image) async {
    try {
      String imageName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageReference =
          FirebaseStorage.instance.ref().child('images/$imageName.jpg');

      await storageReference.putFile(image);
      String downloadUrl = await storageReference.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      throw e;
    }
  }

  Future<Map<String, dynamic>> updateItemReduceAmountInDB(
      String nameId, int amountToReduce, BuildContext context,
      {bool showConfirmationDialog = true}) async {
    try {
      CollectionReference items =
          FirebaseFirestore.instance.collection('Items');

      QuerySnapshot querySnapshot =
          await items.where('Name', isEqualTo: nameId).get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        Item currentItem =
            Item.fromFirestore(doc.data() as Map<String, dynamic>);

        int newAmount = currentItem.amount - amountToReduce;

        if (newAmount >= 0) {
          await doc.reference.update({
            'Amount': newAmount,
          });

          _updateStreamController.add(null);
          return {'success': true, 'error': UpdateError.none};
        } else if (newAmount < 0 && showConfirmationDialog) {
          bool deleteItem =
              await AlertDialogUtils.showDeleteConfirmationDialog(context);
          if (deleteItem) {
            await doc.reference.delete();
            Navigator.of(context).pop();
            return deleteItem
                ? {'success': true, 'error': UpdateError.none}
                : {'success': false, 'error': UpdateError.userCancelled};
          } else {
            return {'success': false, 'error': UpdateError.firebaseError};
          }
        }
      }
    } on FirebaseException {
      return {'success': false, 'error': UpdateError.firebaseError};
    }
    return {'success': false, 'error': UpdateError.invalidAmount};
  }

  //This methods looks at the current amount of a specific item and adds an x amount.
  Future<Map<String, dynamic>> updateItemAddAmountInDB(
      String nameId, int amountToAdd) async {
    try {
      //Looks at the collection "Items"
      CollectionReference items =
          FirebaseFirestore.instance.collection('Items');
      //Looks at the field "Name" and compare to what is given in the parameter of nameId.
      QuerySnapshot querySnapshot =
          await items.where('Name', isEqualTo: nameId).get();
      //This for loop creates a new int to hold the updated value. Then it looks at the currentAmount and adds the amountToAdd given in the parameter.
      //Then it puts the updated value of newAmount as the value for the "Amount" field in the database for this specific item.
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        Item currentItem =
            Item.fromFirestore(doc.data() as Map<String, dynamic>);
        int newAmount = currentItem.amount + amountToAdd;
        await doc.reference.update({
          'Amount': newAmount,
        });
        _updateStreamController.add(null);
      }
      //Returns true and gives no error if this try is succesfull.
      return {'success': true, 'error': UpdateError.none};
    } catch (e) {
      //Returns false and gives an error if it is catched.
      return {'success': false, 'error': UpdateError.firebaseError};
    }
  }

  Future<Map<String, dynamic>> getItemFromDB(String itemName) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Items')
          .where('Name', isEqualTo: itemName)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return {
          'item': Item.fromFirestore(
              querySnapshot.docs[0].data() as Map<String, dynamic>),
          'error': UpdateError.none,
        };
      } else {
        return {'item': null, 'error': UpdateError.itemNotFound};
      }
    } catch (e) {
      return {'item': null, 'error': UpdateError.firebaseError};
    }
  }

  Future<Map<String, dynamic>> getAllItems() async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Items').get();
      List<Item> items = querySnapshot.docs
          .map((doc) => Item.fromFirestore(doc.data() as Map<String, dynamic>))
          .toList();

      return {'items': items, 'error': UpdateError.none};
    } catch (e) {
      return {'items': <Item>[], 'error': UpdateError.firebaseError};
    }
  }

  Future<List<Item>> getItemsForRecipe(Recipe? recipe) async {
  if (recipe == null) {
    // Handle the case where recipe is null, return an empty list or handle as needed
    return [];
  }

  List<Item> items = [];

  for (int i = 0; i < recipe.itemIds.length; i++) {
    String itemId = recipe.itemIds[i];
    DocumentSnapshot itemSnapshot =
        await firestore.collection('Items').doc(itemId).get();

    if (itemSnapshot.exists) {
      Item item = Item.fromFirestore(itemSnapshot.data() as Map<String, dynamic>);
      items.add(item);
    }
  }

  return items;
}

}



