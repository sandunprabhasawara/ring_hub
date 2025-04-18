import 'package:shared_preferences/shared_preferences.dart';

class FavouriteManager {
  static const String key = 'favourite_audio_ids';

  // Get favourite audio IDs
  static Future<List<String>> getFavouriteAudioIds() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key) ?? [];
  }

  // Add an ID to favourites
  static Future<void> addToFavourites(String audioId) async {
    final prefs = await SharedPreferences.getInstance();
    final favs = prefs.getStringList(key) ?? [];
    if (!favs.contains(audioId)) {
      favs.add(audioId);
      await prefs.setStringList(key, favs);
    }
  }

  // Remove an ID from favourites
  static Future<void> removeFromFavourites(String audioId) async {
    final prefs = await SharedPreferences.getInstance();
    final favs = prefs.getStringList(key) ?? [];
    if (favs.contains(audioId)) {
      favs.remove(audioId);
      await prefs.setStringList(key, favs);
    }
  }

  // Toggle favourite (add if not exists, remove if exists)
  static Future<void> toggleFavourite(String audioId) async {
    final favs = await getFavouriteAudioIds();
    if (favs.contains(audioId)) {
      await removeFromFavourites(audioId);
    } else {
      await addToFavourites(audioId);
    }
  }

  // Check if audio is favourited
  static Future<bool> isFavourite(String audioId) async {
    final favs = await getFavouriteAudioIds();
    return favs.contains(audioId);
  }
}
