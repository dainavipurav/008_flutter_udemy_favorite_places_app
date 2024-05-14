import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_007_favorite_places_app/models/place.dart';

final places = [];

class PlaceNotifier extends StateNotifier<List<Place>> {
  PlaceNotifier() : super([]);
}

final placesProvider = StateNotifierProvider<PlaceNotifier, List<Place>>((ref) {
  return PlaceNotifier();
});
