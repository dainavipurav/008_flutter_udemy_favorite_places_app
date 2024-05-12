import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_007_favorite_places_app/models/place_model.dart';

final places = [];

class PlaceNotifier extends StateNotifier<List<PlaceModel>> {
  PlaceNotifier() : super([]);
}

final placesProvider =
    StateNotifierProvider<PlaceNotifier, List<PlaceModel>>((ref) {
  return PlaceNotifier();
});
