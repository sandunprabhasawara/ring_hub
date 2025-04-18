import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musicapp/models/audio_model.dart';

class EachCategoryProvider extends StateNotifier<List<Audio>> {
  EachCategoryProvider() : super([]);

  void filterByCategory(String categoryId, List<Audio> allAudios) {
    state = allAudios
        .where((audio) => audio.keywords.contains(categoryId))
        .toList();
  }
}

final eachCategoryProvider = StateNotifierProvider((ref) {
  return EachCategoryProvider();
});
