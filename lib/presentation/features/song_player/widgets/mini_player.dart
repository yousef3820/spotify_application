import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spotify_application_1/presentation/features/song_player/bloc/cubit/song_player_cubit.dart';
import 'package:flutter_spotify_application_1/presentation/features/song_player/pages/song_player_page.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
      builder: (context, state) {
        final cubit = context.read<SongPlayerCubit>();
        final song = cubit.currentSong;
        if (song == null) return const SizedBox.shrink();
        return GestureDetector(
          onTap: () {
            final song = context.read<SongPlayerCubit>().currentSong;
            if (song != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SongPlayerPage(songplayer: song),
                ),
              );
            }
          },
          child: Container(
            height: 60,
            color: Colors.black,
            child: Row(
              children: [
                Image.network(song.url, width: 40, height: 40),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    song.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    cubit.audioPlayer.playing ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                  ),
                  onPressed: () => cubit.playPauseSong(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
