import 'dart:io';
import 'package:flutter/material.dart';
import 'package:undineinventorysystem/widgets/create_widgets/create_widgets.dart';
import 'package:undineinventorysystem/services/item_service.dart';
import 'package:image_picker/image_picker.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();
  final tagController = TextEditingController();
  final ItemService _itemService = ItemService();
  File? _selectedImage;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 150),
              const CreateTitle(),
              const SizedBox(height: 20),
              NameInputField(controller: nameController),
              const SizedBox(height: 20),
              AmountInputField(controller: amountController),
              const SizedBox(height: 20),
              DescriptionInputField(controller: descriptionController),
              const SizedBox(height: 20),
              TagInputField(controller: tagController),
              const SizedBox(height: 20),
              _buildImageField(),
              const SizedBox(height: 20),
              CreateButton(onCreate: () => CreateItem(context)),
              const SizedBox(height: 20),
              CancelButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageField() {
    return Column(
      children: [
        _selectedImage != null
            ? Image.file(
                _selectedImage!,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              )
            : Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.camera_alt,
                    color: const Color.fromARGB(218, 1, 15, 58), // Set the desired color here
                  ),
                  onPressed: _takePicture,
                ),
              ),
      ],
    );
  }

  void _takePicture() async {
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  void CreateItem(BuildContext context) async {
    try {
      String name = nameController.text.trim();
      int amount = int.tryParse(amountController.text.trim()) ?? 0;
      String description = descriptionController.text.trim();
      String tag = tagController.text.trim();

      if (name.isEmpty || amount <= 0 || description.isEmpty) {
        return;
      }

      await _itemService.createItemToDB(
          name, amount, description, tag, _selectedImage!);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Item created successfully'),
          duration: Duration(seconds: 2),
        ),
      );

      Navigator.of(context).pop();
    } catch (e) {
      print('Error creating item: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error creating item'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
