import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favorite_places/models/place.dart';

class PlacesNotifier extends StateNotifier<List<Place>> {
  PlacesNotifier() : super([]);

  void setPlaces(List<Place> places) {
    state = places;
  }

  void addPlace(String title, File image, PlaceLocation location) {
    final newPlace = Place(
      title: title,
      image: image,
      location: location,
    );
    state = [newPlace, ...state];
  }
}

final placesProvider = StateNotifierProvider<PlacesNotifier, List<Place>>(
  (ref) => PlacesNotifier(),
);
