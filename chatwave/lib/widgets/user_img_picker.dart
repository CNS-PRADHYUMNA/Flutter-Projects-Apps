import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserImgPicker extends StatefulWidget {
  const UserImgPicker({super.key, required this.onPickImage});

  final void Function(File pickedImg) onPickImage;

  @override
  State<UserImgPicker> createState() => _UserImgPickerState();
}

class _UserImgPickerState extends State<UserImgPicker> {
  File? _pickedImgFile;

  void _pickImg() async {
    final pickedImg = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (pickedImg == null) {
      return;
    }
    setState(() {
      _pickedImgFile = File(pickedImg.path);
    });
    widget.onPickImage(_pickedImgFile!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          foregroundImage:
              _pickedImgFile != null ? FileImage(_pickedImgFile!) : null,
        ),
        TextButton.icon(
          onPressed: _pickImg,
          icon: const Icon(Icons.image),
          label: Text(
            'Add Image',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
