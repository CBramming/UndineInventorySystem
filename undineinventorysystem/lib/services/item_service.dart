import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:undineinventorysystem/models/item.dart';
import 'dart:async';

import 'package:undineinventorysystem/widgets/detailed_view_widget/detailed_view_screen_widget.dart';

class ItemService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

// Define the stream controller here
  StreamController<void> _updateStreamController =
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

  Future<bool> updateItemReduceAmountInDB(
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
          return true;
        } else if (newAmount < 0 && showConfirmationDialog) {
          bool deleteItem = await showDeleteConfirmationDialog(context);
          if (deleteItem) {
            await doc.reference.delete();
            Navigator.of(context).pop();
            return true;
          } else {
            return false;
          }
        }
      }
    } on FirebaseException catch (e) {
      return false;
    }
    return false;
  }

  Future<void> updateItemAddAmountInDB(String nameId, int amountToAdd) async {
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
    } catch (e) {
      print('Error updating item amount: $e');
    }
  }

  Future<Item?> getItemFromDB(String itemName) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Items')
          .where('Name', isEqualTo: itemName)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return Item.fromFirestore(
            querySnapshot.docs[0].data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching item: $e');
      return null;
    }
  }

  Future<List<Item>> getAllItems() async {
    try {
      await Future.delayed(Duration(seconds: 1));

      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Items').get();
      return querySnapshot.docs
          .map((doc) => Item.fromFirestore(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error fetching items: $e');
      return [];
    }
  }
}
