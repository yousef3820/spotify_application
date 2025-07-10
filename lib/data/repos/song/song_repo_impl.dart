import 'package:dartz/dartz.dart';
import 'package:flutter_spotify_application_1/data/datasource/song/song_appwrite_service.dart';
import 'package:flutter_spotify_application_1/data/model/song/song.dart';
import 'package:flutter_spotify_application_1/domain/entities/song/song.dart';
import 'package:flutter_spotify_application_1/domain/repos/song/song_repo.dart';

class SongRepoImpl extends SongRepo {
  final SongAppwriteService songAppwriteService;
  SongRepoImpl({required this.songAppwriteService});

  @override
  Future<Either<String, List<SongEntity>>> GetNewsSongs() async {
    try {
      final songsData = await songAppwriteService.getNewestSongs();
      final songs = songsData.map((json) => SongModel.fromJson(json).toEntity()).toList();
      return right(songs);
    } catch (e) {
      return left(e.toString());
    }
  }
  
  @override
  Future<Either> getPlayList() async{
     try {
      final songsData = await songAppwriteService.getPlayList();
      final songs = songsData.map((json) => SongModel.fromJson(json).toEntity()).toList();
      return right(songs);
    } catch (e) {
      return left(e.toString());
    }
  }
  @override
  Future<Either<String, SongEntity>> getSongByUrl(String url) async {
    try {
      final songsData = await songAppwriteService.getPlayList();
      final songJson = songsData.firstWhere(
        (json) => json['url'] == url,
        orElse: () => throw Exception('Song not found'),
      );
      final song = SongModel.fromJson(songJson).toEntity();
      print("/////////////////////////////");
      print(song.artist);
      print("///////////////////////////////");
      return right(song);
    } catch (e) {
      return left(e.toString());
    }
  }
  @override
Future<Either<String, List<SongEntity>>> searchSongs(String query) async {
  try {
    final songsData = await songAppwriteService.searchSongs(query);
    final songs = songsData.map((json) => SongModel.fromJson(json).toEntity()).toList();
    return right(songs);
  } catch (e) {
    return left(e.toString());
  }
}
}