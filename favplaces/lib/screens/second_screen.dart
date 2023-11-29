import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favplaces/providers/users_places.dart';
import 'package:favplaces/widgets/image_input.dart';
import 'dart:io';

class AddPlace extends ConsumerStatefulWidget {
  const AddPlace({super.key});

  @override
  ConsumerState<AddPlace> createState() => _AddPlaceState();
}

class _AddPlaceState extends ConsumerState<AddPlace> {
  final txt = TextEditingController();

  File? _selectedImage;

  void _savePlace() {
    final etxt = txt.text;
    if (etxt.isEmpty || _selectedImage == null) {
      return;
    }
    ref.read(userPlacesProvider.notifier).addPlace(etxt, _selectedImage!);

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    txt.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add your Fav place... ❤️"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 60,
              child: TextField(
                  controller: txt,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.white, fontSize: 15),
                    hintText: "Enter Place to be added",
                  )),
            ),
            const SizedBox(
              height: 15,
            ),
            ImageInput(
              onPickImage: (img) {
                _selectedImage = img;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              onPressed: _savePlace,
              label: const Text(" Add Place"),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
