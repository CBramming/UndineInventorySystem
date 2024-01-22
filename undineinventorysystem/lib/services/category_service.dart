import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:undineinventorysystem/models/item.dart';
import 'package:undineinventorysystem/services/item_service.dart';
import 'package:undineinventorysystem/utils/error_handler.dart';

class CategoryService {
  Future<Map<String, dynamic>> getItemsByCategory(String categoryName) async {
    try {
      DocumentSnapshot categorySnapshot = await FirebaseFirestore.instance
          .collection('Category')
          .doc(categoryName)
          .get();

      if (categorySnapshot.exists) {
        Map<String, dynamic> categoryData =
            categorySnapshot.data()! as Map<String, dynamic>;

        if (categoryData['components'] is! List) {
          return {'items': <Item>[], 'error': UpdateError.invalidData};
        }
        List<dynamic> componentIds = categoryData['components'];

        List<Future<Map<String, dynamic>>> itemFutures = [];

        for (var componentId in componentIds) {
          String itemId = (componentId as DocumentReference).id;
          itemFutures.add(ItemService().getItemFromDB(itemId));
        }

        List<Map<String, dynamic>> itemsData = await Future.wait(itemFutures);
        List<Item> items = itemsData
            .where((data) => data['error'] == UpdateError.none)
            .map((data) => data['item'] as Item)
            .toList();

        return {'items': items, 'error': UpdateError.none};
      } else {
        return {'items': <Item>[], 'error': UpdateError.categoryNotFound};
      }
    } catch (e) {
      return {'items': <Item>[], 'error': UpdateError.firebaseError};
    }
  }

  Future<Map<String, dynamic>> getAllCategories() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Category').get();

      List<String> categoryNames =
          querySnapshot.docs.map((doc) => doc.id).toList();

      return {'categories': categoryNames, 'error': UpdateError.none};
    } catch (e) {
      return {'categories': <String>[], 'error': UpdateError.firebaseError};
    }
  }
}
