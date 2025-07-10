import 'package:bloc/bloc.dart';
import 'package:flutter_spotify_application_1/domain/entities/song/song.dart';
import 'package:flutter_spotify_application_1/domain/usecases/song/ger_news_song.dart';
import 'package:flutter_spotify_application_1/serviceLocator.dart';
import 'package:meta/meta.dart';

part 'newest_songs_state.dart';

class NewestSongsCubit extends Cubit<NewestSongsState> {
  NewestSongsCubit() : super(NewestSongsLoading()) {
    print("🔄 NewestSongsCubit created");
  }
  Future<void> getNewestSongs() async {
    print("🔄 getNewestSongs() called");
    emit(NewestSongsLoading());
    
    var returnedSongs = await sl<GetNewestSongsUsecase>().execute();
    
    print("🎵 Usecase returned: $returnedSongs");
    
    returnedSongs.fold(
      (l) {
        print("❌ Error: $l");
        emit(NewestSongsFailure());
      },
      (data) {
        print("✅ Success! ${data.length} songs loaded");
        emit(NewestSongsLoaded(songs: data));
      },
    );
  }
}
