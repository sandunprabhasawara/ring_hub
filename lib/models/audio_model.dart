import 'package:uuid/uuid.dart';
import 'dart:convert';

var uuid = Uuid();

class Audio {
  Audio({
    required this.id,
    required this.title,
    required this.profile,
    required this.keywords,
    this.isNotification = false,
    this.isFavourite = false,
    required this.path,
  });

  String id;
  List<String> keywords = [];
  final String title;
  final String profile;
  bool isNotification = false;
  bool isFavourite = false;
  final String path;

  factory Audio.fromJson(Map<String, dynamic> json) {
    List<String> parsedKeywords = [];

    if (json['keywords'] != null && json['keywords'] is List) {
      final List rawKeywords = json['keywords'];

      if (rawKeywords.isNotEmpty && rawKeywords.first is String) {
        try {
          parsedKeywords = List<String>.from(jsonDecode(rawKeywords.first));
        } catch (e) {
          // fallback in case it's not JSON-encoded
          parsedKeywords = rawKeywords.cast<String>();
        }
      }
    }

    return Audio(
      id: json['_id'],
      title: json['title'],
      profile: json['profile'],
      keywords: parsedKeywords,
      isFavourite: json['isFavourite'] ?? false,
      isNotification: json['isNotification'] ?? false,
      path: json['audioUrl'],
    );

    
  }
   Audio copyWith({
    String? id,
    String? title,
    String? profile,
    List<String>? keywords,
    bool? isNotification,
    bool? isFavourite,
    String? path,
  }) {
    return Audio(
      id: id ?? this.id,
      title: title ?? this.title,
      profile: profile ?? this.profile,
      keywords: keywords ?? this.keywords,
      isNotification: isNotification ?? this.isNotification,
      isFavourite: isFavourite ?? this.isFavourite,
      path: path ?? this.path,
    );
}


final keywordsList = [
  'alternative',
  'animal',
  'blue',
  'bollywood',
  'caller',
  'children',
  'classical',
  'comedy',
  'cool',
  'country',
  'creative',
  'dance',
  'electronica',
  'hiphop',
  'holidays',
  'humen',
  'juzz',
  'latin',
  'message',
  'other',
  'pattern',
  'pop',
  'promotion',
  'reggae',
  'religious',
  'rock',
  'sayings',
  'sound effects',
  'update',
  'wintage'
];
}