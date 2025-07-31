import 'package:bloc/bloc.dart';
import 'package:flutter_spotify_application_1/domain/entities/song/song.dart';
import 'package:meta/meta.dart';
import 'package:just_audio/just_audio.dart';

part 'song_player_state.dart';

class SongPlayerCubit extends Cubit<SongPlayerState> {
  SongEntity? currentSong;
  AudioPlayer audioPlayer = AudioPlayer();
  Duration songDuration = Duration.zero;
  Duration songPostition = Duration.zero;
  SongPlayerCubit() : super(SongPlayerLoading()) {
    audioPlayer.positionStream.listen((position) {
      songPostition = position;
      upadateSong();
    });

    audioPlayer.durationStream.listen((duration) {
      songDuration = duration!;
    });
  }

  void upadateSong() {
    emit(SongPlayerLoaded());
  }

  Future<void> loadSong(SongEntity song) async {
    try {
      if (currentSong?.songurl == song.songurl) {
        await audioPlayer.seek(songPostition);
        emit(SongPlayerLoaded());
        return;
      }

      currentSong = song;

      songPostition = Duration.zero;

      await audioPlayer.setUrl(song.songurl);

      if (songPostition > Duration.zero) {
        await audioPlayer.seek(songPostition);
      }

      emit(SongPlayerLoaded());
    } catch (e) {
      emit(SongPlayerFailure());
    }
  }

  void playPauseSong() {
    if (audioPlayer.playing) {
      audioPlayer.pause();
    } else {
      audioPlayer.play();
    }
    emit(SongPlayerLoaded());
  }

  @override
  Future<void> close() {
    audioPlayer.dispose();
    return super.close();
  }

  void seekForward() {
    final newPosition = songPostition + Duration(seconds: 5);
    audioPlayer.seek(newPosition);
  }

  void seekBackward() {
    final newPosition = songPostition - Duration(seconds: 5);
    audioPlayer.seek(
      newPosition >= Duration.zero ? newPosition : Duration.zero,
    );
  }
  void stopMusic() async {
  await audioPlayer.stop();
  currentSong = null;
  songPostition = Duration.zero;
  songDuration = Duration.zero;
  emit(SongPlayerInitial());
}
}
