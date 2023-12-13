import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:undineinventorysystem/models/item.dart';
import 'dart:async';

class ItemService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

// Define the stream controller here
  StreamController<void> _updateStreamController =
      StreamController<void>.broadcast();

  // Getter for the stream
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

  Future<void> updateItemReduceAmountInDB(
      String nameId, int amountToReduce) async {
    try {
      CollectionReference items =
          FirebaseFirestore.instance.collection('Items');

      QuerySnapshot querySnapshot =
          await items.where('Name', isEqualTo: nameId).get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        // Get the current item from the document
        Item currentItem =
            Item.fromFirestore(doc.data() as Map<String, dynamic>);

        // Calculate the new amount after reducing
        int newAmount = currentItem.amount - amountToReduce;

        if (newAmount >= 0) {
          // Update the document with individual fields
          await doc.reference.update({
            'Amount': newAmount,
          });

          // Notify the stream controller that the item has been updated
          _updateStreamController.add(null);
        } else {
          // If the new amount is negative, you may choose to delete the document
          await doc.reference.delete();
        }
      }
    } catch (e) {
      print('Error updating item amount: $e');
    }
  }

  Future<void> updateItemAddAmountInDB(String nameId, int amountToAdd) async {
    try {
      CollectionReference items =
          FirebaseFirestore.instance.collection('Items');

      QuerySnapshot querySnapshot =
          await items.where('Name', isEqualTo: nameId).get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        // Get the current item from the document
        Item currentItem =
            Item.fromFirestore(doc.data() as Map<String, dynamic>);

        // Calculate the new amount after adding
        int newAmount = currentItem.amount + amountToAdd;

        // Update the document with individual fields
        await doc.reference.update({
          'Amount': newAmount,
        });

        // Notify the stream controller that the item has been updated
        _updateStreamController.add(null);
      }
    } catch (e) {
      print('Error updating item amount: $e');
    }
  }

  Future<void> deleteItemToDB(String nameId, int amount) async {
    try {
      CollectionReference items = firestore.collection('Items');

      QuerySnapshot querySnapshot =
          await items.where('Name', isEqualTo: nameId).get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      print('Error');
    }
  }

  Future<Item?> getItemFromDB(String itemName) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Items')
          .where('Name', isEqualTo: itemName)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // If there is a matching document, return the first one
        return Item.fromFirestore(
            querySnapshot.docs[0].data() as Map<String, dynamic>);
      } else {
        // Return null if no matching document is found
        return null;
      }
    } catch (e) {
      print('Error fetching item: $e');
      return null;
    }
  }

  Future<List<Item>> getAllItems() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Items').get();
      return querySnapshot.docs
          .map((doc) => Item.fromFirestore(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error fetching items: $e');
      // Consider a different error handling strategy here
      return [];
    }
  }
}
