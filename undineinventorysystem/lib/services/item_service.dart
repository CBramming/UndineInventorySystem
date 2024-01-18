import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:undineinventorysystem/models/item.dart';
import 'package:undineinventorysystem/utils/alert_dialog_utils.dart';
import 'package:undineinventorysystem/utils/error_handler.dart';
import 'dart:async';

class ItemService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final StreamController<void> _updateStreamController =
      StreamController<void>.broadcast();

  Stream<void> get updateStream => _updateStreamController.stream;

  Future<void> addItemToDB(String nameId, int amount) async {
    try {
      CollectionReference items = firestore.collection('Items');

      await items.add({
        'something': nameId,
        'amount2': amount,
      });
    } catch (e) {
      print('Error');
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

  Future<Map<String, dynamic>> updateItemAddAmountInDB(
      String nameId, int amountToAdd) async {
    try {
      CollectionReference items =
          FirebaseFirestore.instance.collection('Items');
      QuerySnapshot querySnapshot =
          await items.where('Name', isEqualTo: nameId).get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        Item currentItem =
            Item.fromFirestore(doc.data() as Map<String, dynamic>);
        int newAmount = currentItem.amount + amountToAdd;
        await doc.reference.update({
          'Amount': newAmount,
        });
        _updateStreamController.add(null);
      }
      return {'success': true, 'error': UpdateError.none};
    } catch (e) {
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
}
