import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spotify_application_1/common/widgets/appbar/app_bar.dart';
import 'package:flutter_spotify_application_1/core/configs/theme/app_colors.dart';
import 'package:flutter_spotify_application_1/domain/entities/song/song.dart';
import 'package:flutter_spotify_application_1/presentation/features/song_player/bloc/cubit/song_player_cubit.dart';

class SongPlayerPage extends StatelessWidget {
  const SongPlayerPage({super.key, required this.songplayer});
  final SongEntity songplayer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(title: Text("Now Playing")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: Image.network(songplayer.url, fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 17),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        songplayer.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        songplayer.artist,
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xffBABABA),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 52),
              _songPlayer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _songPlayer() {
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
      builder: (context, state) {
        if (state is SongPlayerLoading) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }
        if (state is SongPlayerLoaded) {
          return Column(
            children: [
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Slider(
                      activeColor: AppColors.primary,
                      value: context
                          .read<SongPlayerCubit>()
                          .songPostition
                          .inSeconds
                          .toDouble(),
                      min: 0.0,
                      max: context
                          .read<SongPlayerCubit>()
                          .songDuration
                          .inSeconds
                          .toDouble(),
                      onChanged: (value) {
                        context.read<SongPlayerCubit>().audioPlayer.seek(
                          Duration(seconds: value.toInt()),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          formatDuration(
                            context.read<SongPlayerCubit>().songPostition,
                          ),
                        ),
                        Text(
                          formatDuration(
                            context.read<SongPlayerCubit>().songDuration,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.replay_5),
                    onPressed: () =>
                        context.read<SongPlayerCubit>().seekBackward(),
                  ),
                  GestureDetector(
                    onTap: () =>
                        context.read<SongPlayerCubit>().playPauseSong(),
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary,
                      ),
                      child: Icon(
                        context.read<SongPlayerCubit>().audioPlayer.playing
                            ? Icons.pause
                            : Icons.play_arrow,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.forward_5),
                    onPressed: () {
                      final cubit = context.read<SongPlayerCubit>();
                      if (cubit.songPostition.inSeconds + 5 <
                          cubit.songDuration.inSeconds) {
                        cubit.seekForward();
                      }
                    },
                  ),
                ],
              ),
            ],
          );
        }
        return Container();
      },
    );
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
