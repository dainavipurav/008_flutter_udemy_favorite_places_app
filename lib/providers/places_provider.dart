import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_007_favorite_places_app/models/place.dart';

class PlaceNotifier extends StateNotifier<List<Place>> {
  PlaceNotifier() : super([]);

  void addPlace(String title) {
    final newPlace = Place(title: title);

    state = [
      newPlace,
      ...state,
    ];
  }
}

final placesProvider = StateNotifierProvider<PlaceNotifier, List<Place>>((ref) {
  return PlaceNotifier();
});
