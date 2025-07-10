import 'package:bloc/bloc.dart';
import 'package:flutter_spotify_application_1/domain/entities/song/song.dart';
import 'package:flutter_spotify_application_1/domain/usecases/favourites_usecase.dart';
import 'package:meta/meta.dart';

part 'favourites_cubit_state.dart';

class FavoritesCubit extends Cubit<FavoritesCubitState> {
  final GetFavoritesUseCase getFavorites;
  final AddFavoriteUseCase addFavorite;
  final RemoveFavoriteUseCase removeFavorite;
  final GetSongByUrlUseCase getSongByUrl;

  Set<String> _favorites = {};
  Map<String, SongEntity> _favoriteSongs = {};

  FavoritesCubit(
    this.getFavorites,
    this.addFavorite,
    this.removeFavorite,
    this.getSongByUrl, // Add this
  ) : super(FavoritesCubitInitial());

  Future<void> loadFavorites() async {
    emit(FavoritesCubitLoading());
    try {
      final favorites = await getFavorites();
      _favorites = Set.from(favorites);
      _favoriteSongs.clear();
      for (final url in _favorites) {
        final result = await getSongByUrl(url);
        result.fold(
          (error) => print('Error loading song $url: $error'),
          (song) => _favoriteSongs[url] = song,
        );
      }
      
      emit(FavoritesCubitLoaded(
        favorites: _favorites.toList(),
        favoriteSongs: _favoriteSongs,
      ));
    } catch (e) {
      emit(FavoritesCubitFailure(message: e.toString()));
    }
  }

  Future<void> addToFavorites(String url) async {
    try {
      // First get the song details
      final result = await getSongByUrl(url);
      result.fold(
        (error) => emit(FavoritesCubitFailure(message: error)),
        (song) async {
          await addFavorite(url);
          _favorites.add(url);
          _favoriteSongs[url] = song;
          emit(FavoritesCubitLoaded(
            favorites: _favorites.toList(),
            favoriteSongs: _favoriteSongs,
          ));
        },
      );
    } catch (e) {
      emit(FavoritesCubitFailure(message: e.toString()));
    }
  }

  Future<void> removeFromFavorites(String url) async {
    try {
      await removeFavorite(url);
      _favorites.remove(url);
      _favoriteSongs.remove(url);
      emit(FavoritesCubitLoaded(
        favorites: _favorites.toList(),
        favoriteSongs: _favoriteSongs,
      ));
    } catch (e) {
      emit(FavoritesCubitFailure(message: e.toString()));
    }
  }

  bool isFavorite(String url) => _favorites.contains(url);
}