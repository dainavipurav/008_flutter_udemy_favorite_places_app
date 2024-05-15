import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_007_favorite_places_app/models/place.dart';
import 'package:udemy_007_favorite_places_app/providers/user_places_provider.dart';
import 'package:udemy_007_favorite_places_app/widgets/image_input.dart';
import 'package:udemy_007_favorite_places_app/widgets/location_input.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() {
    return _AddPlaceScreenState();
  }
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _textController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  File? _selectedImage;
  PlaceLocation? _selectedLocation;

  void _savePlace() {
    if (formKey.currentState!.validate()) {
      // Selected Image validation
      if (_selectedImage == null) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Please add place image',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            backgroundColor: Theme.of(context).colorScheme.surface,
          ),
        );
        return;
      }

      // Selected location validation
      if (_selectedLocation == null) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Please add location',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            backgroundColor: Theme.of(context).colorScheme.surface,
          ),
        );
        return;
      }

      formKey.currentState!.save();
      ref.read(userPlacesProvider.notifier).addPlace(
            _textController.text,
            _selectedImage!,
            _selectedLocation!,
          );
      Navigator.pop(context);
    }
  }

  String? _titleValidator(value) {
    if (value == null || value.isEmpty || value.toString().trim().isEmpty) {
      return 'Please enter place name';
    }
    return null;
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(label: Text('Title')),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    validator: _titleValidator,
                    keyboardType: TextInputType.text,
                    controller: _textController,
                  ),
                  const SizedBox(height: 16),
                  ImageInput(
                    onSelectImage: (image) {
                      _selectedImage = image;
                    },
                  ),
                  const SizedBox(height: 16),
                  LocationInput(
                    onSelectLocation: (selectedLocation) {
                      selectedLocation = selectedLocation;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              onPressed: _savePlace,
              label: const Text('Add Place'),
            ),
          ],
        ),
      ),
    );
  }
}
