import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:undineinventorysystem/models/item.dart';

class ItemService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

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

  Future<void> deleteItemToDB(String nameId, int amount) async {
    try {
      CollectionReference items = firestore.collection('Items');

      QuerySnapshot querySnapshot =
          await items.where('something', isEqualTo: nameId).get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      print('Error');
    }
  }

  Future<Item?> getItemFromDB(String nameId) async {
    try {
      DocumentSnapshot itemSnapshot = await FirebaseFirestore.instance
          .collection('Items')
          .doc(nameId)
          .get();

      if (itemSnapshot.exists) {
        // Assuming the data structure in Firestore matches your Item model
        return Item.fromFirestore(itemSnapshot.data() as Map<String, dynamic>);
      }
      return null;
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
      return [];
    }
  }

  Future<String> getNameFromFirebase(String nameId) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('Items')
          .doc(nameId)
          .get();

      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

      return data?['Name'] ?? 'Default Text';
    } catch (e) {
      print('Error getting data from Firebase: $e');
      return 'Error';
    }
  }

  Future<String> getAmountFromFirebase(String nameId) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('Items')
          .doc(nameId)
          .get();

      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

      return data?['Amount'] ?? 'Default Text';
    } catch (e) {
      print('Error getting data from Firebase: $e');
      return 'Error';
    }
  }

  Future<String> getDescriptionFromFirebase(String nameId) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('Items')
          .doc(nameId)
          .get();

      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

      return data?['Description'] ?? 'Default Text';
    } catch (e) {
      print('Error getting data from Firebase: $e');
      return 'Error';
    }
  }
}
