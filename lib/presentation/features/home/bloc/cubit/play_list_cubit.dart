import 'package:bloc/bloc.dart';
import 'package:flutter_spotify_application_1/domain/entities/song/song.dart';
import 'package:flutter_spotify_application_1/domain/usecases/song/get_play_list_song.dart';
import 'package:flutter_spotify_application_1/serviceLocator.dart';
import 'package:meta/meta.dart';

part 'play_list_state.dart';

class PlayListCubit extends Cubit<PlayListState> {
  PlayListCubit() : super(PlayListLoading()) {
    print("🔄 NewestSongsCubit created");
  }
  Future<void> getPlayList() async {
    print("🔄 getNewestSongs() called");
    emit(PlayListLoading());
    
    var returnedSongs = await sl<GetPlayListSongUsecase>().execute();
    
    print("🎵 Usecase returned: $returnedSongs");
    
    returnedSongs.fold(
      (l) {
        print("❌ Error: $l");
        emit(PlayListFailure());
      },
      (data) {
        print("✅ Success! ${data.length} songs loaded");
        emit(PlayListLoaded(songs: data));
      },
    );
  }
}
