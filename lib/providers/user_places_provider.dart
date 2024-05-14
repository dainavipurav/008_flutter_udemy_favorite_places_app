import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_007_favorite_places_app/models/place.dart';

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super([]);

  void addPlace(String title, File image) {
    final newPlace = Place(
      title: title,
      image: image,
    );

    state = [
      newPlace,
      ...state,
    ];
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>((ref) {
  return UserPlacesNotifier();
});
