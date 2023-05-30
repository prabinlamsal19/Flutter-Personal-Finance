import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:image_picker_web/image_picker_web.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/models/blog_model.dart';

class AddPersonalBlogPage extends StatefulWidget {
  const AddPersonalBlogPage({Key? key}) : super(key: key);

  @override
  AddPersonalBlogPageState createState() => AddPersonalBlogPageState();
}

class AddPersonalBlogPageState extends State<AddPersonalBlogPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  Image? _selectedImage;

  Future<void> _selectImage() async {
    // Image? fromPicker = await ImagePickerWeb.getImageAsWidget();
    // setState(() {
    //   _selectedImage = fromPicker;
    // });
    final ImagePicker picker = ImagePicker();
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    final List<XFile>? files = response.files;
    if (files != null) {}

    _selectedImage = Image.asset("assets/bgg.jpeg");
  }

  @override
  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _addBlog() {
    String title = _titleController.text;
    String content = _contentController.text;

    if (title.isNotEmpty && content.isNotEmpty) {
      Navigator.pop(
        context,
        BlogModel(title: title, content: content, image: _selectedImage),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Add Blog'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _contentController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Content',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _selectImage,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(Icons.image),
              label: const Text(
                'Select Image',
                style: TextStyle(fontSize: 12),
              ),
            ),
            if (_selectedImage != null) ...[
              const SizedBox(height: 16),
              Image(
                image: _selectedImage!.image,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ],
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _addBlog,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(Icons.add),
              label: const Text(
                'Add Blog',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
