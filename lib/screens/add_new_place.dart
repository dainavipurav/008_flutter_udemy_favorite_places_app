import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_007_favorite_places_app/models/place_model.dart';
import 'package:udemy_007_favorite_places_app/providers/places_provider.dart';

class AddNewPlace extends ConsumerWidget {
  const AddNewPlace({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = TextEditingController();
    final wref = ref.watch(placesProvider);
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Place'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Form(
              key: formKey,
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter place name';
                  }
                  return null;
                },
                onSaved: (value) {},
                keyboardType: TextInputType.text,
                controller: textController,
              ),
            ),
            const SizedBox(height: 20),
            TextButton.icon(
              icon: const Icon(Icons.add),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  PlaceModel model = PlaceModel(
                      id: Random(1000).toString(), name: textController.text);
                  wref.add(model);

                  print(wref.length);

                  Navigator.pop(context);
                }
              },
              label: const Text('Add Place'),
            ),
          ],
        ),
      ),
    );
  }
}
