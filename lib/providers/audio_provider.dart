// audio_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musicapp/models/audio_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// Your fetch function
Future<List<Audio>> fetchAudioFromApi() async {
  final response =
      await http.get(Uri.parse('http://192.168.147.201:8080/audio/audios'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonBody = jsonDecode(response.body);
    final List<dynamic> audioList = jsonBody['audios'];
    return audioList.map((json) => Audio.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load audios: ${response.statusCode}');
  }
}

// StateNotifier for managing audio state
class AudioNotifier extends StateNotifier<AsyncValue<List<Audio>>> {
  AudioNotifier() : super(const AsyncValue.loading()) {
    loadAudios();
  }

  Future<void> loadAudios() async {
    try {
      final audios = await fetchAudioFromApi();
      state = AsyncValue.data(audios);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  // Optional: Add audio locally
  void addAudio(Audio audio) {
    state.whenData((list) {
      final updatedList = [...list, audio];
      state = AsyncValue.data(updatedList);
    });
  }

  // Optional: Refresh from server
  Future<void> refresh() async {
    await loadAudios();
  }
}

// StateNotifierProvider
final audioProvider =
    StateNotifierProvider<AudioNotifier, AsyncValue<List<Audio>>>(
  (ref) => AudioNotifier(),
);

// Derived providers (filtered, notifications, etc.)
final filteredAudioProvider =
    Provider.family<List<Audio>, String>((ref, categoryId) {
  final audioAsync = ref.watch(audioProvider);
  return audioAsync.maybeWhen(
    data: (list) =>
        list.where((audio) => audio.keywords.contains(categoryId)).toList(),
    orElse: () => [],
  );
});

final allAudioProvider = Provider<List<Audio>>((ref) {
  final audioAsync = ref.watch(audioProvider);
  return audioAsync.maybeWhen(
    data: (list) => list,
    orElse: () => [],
  );
});

final ringtoneAudioProvider = Provider<List<Audio>>((ref) {
  final audioAsync = ref.watch(audioProvider);
  return audioAsync.maybeWhen(
    data: (audioList) =>
        audioList.where((audio) => !audio.isNotification).toList(),
    orElse: () => [],
  );
});

final notificationAudioProvider = Provider<List<Audio>>((ref) {
  final audioAsync = ref.watch(audioProvider);
  return audioAsync.maybeWhen(
    data: (audioList) =>
        audioList.where((audio) => audio.isNotification).toList(),
    orElse: () => [],
  );
});
