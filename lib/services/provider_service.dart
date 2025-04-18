import 'package:http/http.dart' as http;
import 'package:musicapp/models/audio_model.dart';
import 'dart:convert';

class ProviderService {
  getAudios() async{
    final url = Uri.parse('http://localhost:8080/audio/audios');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body) as List<dynamic>;
      final audioList = parsed.map((json) => Audio.fromJson(json)).toList();
      return audioList;
    } else {
      throw Exception('Failed to load audio files');
    }
  }
}