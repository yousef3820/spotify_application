import 'package:dartz/dartz.dart';
import 'package:flutter_spotify_application_1/domain/entities/song/song.dart';
import 'package:flutter_spotify_application_1/domain/repos/auth/auth_repo.dart';
import 'package:flutter_spotify_application_1/domain/repos/song/song_repo.dart';

class GetFavoritesUseCase {
  final AuthRepository repository;
  GetFavoritesUseCase(this.repository);
  Future<List<String>> call() => repository.getFavorites();
}

class AddFavoriteUseCase {
  final AuthRepository repository;
  AddFavoriteUseCase(this.repository);
  Future<void> call(String itemId) => repository.addFavorite(itemId);
}

class RemoveFavoriteUseCase {
  final AuthRepository repository;
  RemoveFavoriteUseCase(this.repository);
  Future<void> call(String itemId) => repository.removeFavorite(itemId);
}

class GetSongByUrlUseCase {
  final SongRepo songRepo;
  GetSongByUrlUseCase(this.songRepo);
  Future<Either<String, SongEntity>> call(String url) async {
    return await songRepo.getSongByUrl(url);
  }
}