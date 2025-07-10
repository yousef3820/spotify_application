import 'package:flutter_spotify_application_1/domain/entities/song/song.dart';

class SongModel {
  final String artist;
  final String title;
  final double duration;
  final DateTime releaseDate;
  final String url;
  final String songurl;
  SongModel({
    required this.artist,
    required this.title,
    required this.duration,
    required this.releaseDate,
    required this.url,
    required this.songurl,
  });

  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
      artist: json['artist'] as String,
      title: json['title'] as String,
      duration: (json['duration'] as num).toDouble(),
      releaseDate: DateTime.parse(json['releaseDate']),
      url: json['url'] as String,
      songurl: json['songurl'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'artist': artist,
    'title': title,
    'duration': duration,
    'releaseDate': releaseDate.toIso8601String(),
    'url': url,
    'songutl' : songurl,
  };
}

extension SongModelX on SongModel {
  SongEntity toEntity() {
    return SongEntity(
      artist: artist,
      title: title,
      duration: duration,
      releaseDate: releaseDate,
      url: url,
      songurl: songurl,
    );
  }
}