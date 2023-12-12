class Item {
  final String name;
  final String description;
  final int amount;
  final String imageUrl;

  Item(
      {required this.name,
      this.description = '',
      this.amount = 0,
      required this.imageUrl});

  factory Item.fromFirestore(Map<String, dynamic> firestoreData) {
    return Item(
      name: firestoreData['Name'] as String? ?? 'Default Item Name',
      description: firestoreData['Description'] as String? ?? 'No Description',
      amount: firestoreData['Amount'] as int? ?? 0,
      imageUrl: firestoreData['imageUrl'] as String? ?? 'No Image',
    );
  }
}
