import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageInput extends StatefulWidget {
  const ImageInput({Key? key, required this.onPickImage}) : super(key: key);

  final void Function(File img) onPickImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? imag1;

  void _takePic() async {
    final imagePicker = ImagePicker();
    final selectedimg =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);

    if (selectedimg == null) {
      return;
    }

    setState(() {
      imag1 = File(selectedimg.path);
    });
    widget.onPickImage(imag1!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      icon: const Icon(Icons.camera),
      label: const Text('Take Picture'),
      onPressed: _takePic,
    );
    if (imag1 != null) {
      content = GestureDetector(
        onTap: _takePic,
        child: Image.file(
          imag1!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      child: content,
    );
  }
}
