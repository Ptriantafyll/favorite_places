import 'dart:io';

import 'package:favorite_places/widgets/image_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favorite_places/providers/places_provider.dart';

class NewPlaceScreen extends ConsumerStatefulWidget {
  const NewPlaceScreen({super.key});

  @override
  ConsumerState<NewPlaceScreen> createState() {
    return _NewPlaceScreenState();
  }
}

class _NewPlaceScreenState extends ConsumerState<NewPlaceScreen> {
  final _formKey = GlobalKey<FormState>();
  var _enteredPlaceName = '';
  File? _selectedImage;

  void _saveNewPlace() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_selectedImage == null) {
        return;
      }

      ref
          .read(placesProvider.notifier)
          .addPlace(_enteredPlaceName, _selectedImage!);

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new place'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _enteredPlaceName,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                maxLength: 50,
                decoration: InputDecoration(
                  label: const Text('Name'),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1 ||
                      value.trim().length > 50) {
                    return 'Must be between 1 and 50 characters';
                  }
                  return null;
                },
                onSaved: (value) {
                  _enteredPlaceName = value!;
                },
              ),
              const SizedBox(height: 16),
              ImageInput(
                onSelectImage: (image) {
                  _selectedImage = image;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: _saveNewPlace,
                    child: const Text('Add place'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
