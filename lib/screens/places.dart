import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/screens/new_place.dart';
import 'package:favorite_places/widgets/places_list.dart';
import 'package:favorite_places/providers/places_provider.dart';

class PlacesListScreen extends ConsumerWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void addPlace() async {
      final newPlace =
          await Navigator.of(context).push(MaterialPageRoute<Place>(
        builder: (ctx) => NewPlaceScreen(),
      ));
      if (newPlace == null) {
        return;
      }
    }

    final myPlaces = ref.watch(placesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: addPlace,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: PlacesList(
        places: myPlaces,
      ),
    );
  }
}
