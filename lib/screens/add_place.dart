import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_007_favorite_places_app/providers/user_places_provider.dart';
import 'package:udemy_007_favorite_places_app/widgets/image_input.dart';

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

  void _savePlace() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      ref.read(userPlacesProvider.notifier).addPlace(_textController.text);
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
                  const ImageInput(),
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
