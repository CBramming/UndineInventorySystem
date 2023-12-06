import 'package:cloud_firestore/cloud_firestore.dart';

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

  Future<bool> getItemFromDB(String nameId) async {
    try {
      DocumentSnapshot itemSnapshot = await FirebaseFirestore.instance
          .collection('Items')
          .doc(nameId)
          .get();

      if (itemSnapshot.exists) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error fetching item: $e');
      return false;
    }
  }
}
