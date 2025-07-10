// domain/usecases/song/search_songs_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:flutter_spotify_application_1/core/configs/usecase/usecase.dart';
import 'package:flutter_spotify_application_1/domain/entities/song/song.dart';
import 'package:flutter_spotify_application_1/domain/repos/song/song_repo.dart';

class SearchSongsUsecase implements Usecase<Either<String, List<SongEntity>>, String> {
  final SongRepo songRepo;

  SearchSongsUsecase(this.songRepo);

  @override
  Future<Either<String, List<SongEntity>>> execute({String? params}) async {
    if (params == null || params.isEmpty) {
      return Left('Search query cannot be empty');
    }
    return await songRepo.searchSongs(params);
  }
}