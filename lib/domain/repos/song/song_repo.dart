import 'package:dartz/dartz.dart';
import 'package:flutter_spotify_application_1/domain/entities/song/song.dart';

abstract class SongRepo {
  Future<Either> GetNewsSongs();
  Future<Either> getPlayList();
  Future<Either<String, SongEntity>> getSongByUrl(String url); 
  Future<Either<String, List<SongEntity>>> searchSongs(String query);
}