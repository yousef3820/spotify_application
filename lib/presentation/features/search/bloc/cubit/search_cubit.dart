// presentation/features/search/bloc/search_cubit.dart
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_spotify_application_1/domain/entities/song/song.dart';
import 'package:flutter_spotify_application_1/domain/usecases/song/search_songs_usecase.dart';
import 'package:meta/meta.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchSongsUsecase searchSongsUsecase;
  Timer? _debounce;

  SearchCubit(this.searchSongsUsecase) : super(SearchInitial());

  Future<void> searchSongs(String query) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }
    _debounce = Timer(const Duration(milliseconds: 400), () async {
      if (query.isEmpty) {
        emit(SearchInitial());
        return;
      }

      emit(SearchLoading());
      final results = await searchSongsUsecase.execute(params: query);
      results.fold(
        (error) => emit(SearchError(error)),
        (songs) => emit(SearchLoaded(songs)),
      );
    });
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
