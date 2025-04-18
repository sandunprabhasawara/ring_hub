import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:musicapp/models/audio_model.dart';

class FavouriteAudioNotifier extends StateNotifier<List<Audio>> {
  FavouriteAudioNotifier() : super([]);

  Future<void> toggleFavourite(Audio audio) async {
    final isNowFavourite = !audio.isFavourite;

    // Optimistic update in UI
    final updatedAudio = audio.copyWith(isFavourite: isNowFavourite);
    if (isNowFavourite) {
      state = [...state, updatedAudio];
    } else {
      state = state.where((a) => a.id != audio.id).toList();
    }
    // print('http://localhost:3000/audio/toggle-favourite/${audio.id}');

    try {
      final response = await http.post(
        Uri.parse('http://localhost:3001/audio/toggle-favourite/${audio.id}'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'isFavourite': isNowFavourite}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update favourite');
      }
    } catch (e) {
      // Revert change if request failed
      if (isNowFavourite) {
        state = state.where((a) => a.id != audio.id).toList();
      } else {
        state = [...state, audio];
      }
    }
  }

  bool isFavourite(String id) {
    return state.any((audio) => audio.id == id);
  }
}

final favouriteAudioProvider =
    StateNotifierProvider<FavouriteAudioNotifier, List<Audio>>(
  (ref) => FavouriteAudioNotifier(),
);

final favouriteAudiosProvider = FutureProvider<List<Audio>>((ref) async {
  final response = await http.get(
    Uri.parse(
        'http://192.168.90.38:3001/audio/favourites'), // Update with your backend route
    headers: {
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> decoded = jsonDecode(response.body);
    final List audiosList = decoded['audios']; // Access the 'audios' field
    return audiosList.map((item) => Audio.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load favourite audios');
  }
});
