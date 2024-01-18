class Item {
  final String name;
  final String description;
  int amount;
  final String imageUrl;
  final List<String> tags;

  Item({
    required this.name,
    this.description = '',
    this.amount = 0,
    required this.imageUrl,
    this.tags = const [],
  });

  factory Item.fromFirestore(Map<String, dynamic> firestoreData) {
    List<String> parsedTags = [];
    if (firestoreData['tags'] is List) {
      parsedTags = List.from(firestoreData['tags'])
          .map((tag) => tag.toString())
          .toList();
    }

    return Item(
      name: firestoreData['Name'] as String? ?? 'Default Item Name',
      description: firestoreData['Description'] as String? ?? 'No Description',
      amount: firestoreData['Amount'] as int? ?? 0,
      imageUrl: firestoreData['imageUrl'] as String? ?? 'No Image',
      tags: parsedTags,
    );
  }
}
