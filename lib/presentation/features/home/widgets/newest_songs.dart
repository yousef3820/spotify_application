import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spotify_application_1/common/helpers/is_dark_mode.dart';
import 'package:flutter_spotify_application_1/core/configs/theme/app_colors.dart';
import 'package:flutter_spotify_application_1/presentation/features/home/bloc/cubit/newest_songs_cubit.dart';
import 'package:flutter_spotify_application_1/presentation/features/song_player/bloc/cubit/song_player_cubit.dart';
import 'package:flutter_spotify_application_1/presentation/features/song_player/pages/song_player_page.dart';

class NewestSongs extends StatelessWidget {
  const NewestSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewestSongsCubit()..getNewestSongs(),
      child: BlocBuilder<NewestSongsCubit, NewestSongsState>(
        builder: (context, state) {
          if (state is NewestSongsLoading) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          } else if (state is NewestSongsLoaded) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.songs.length,
              itemBuilder: (context, index) {
                final song = state.songs[index];
                return GestureDetector(
                  onTap: () {
                    context.read<SongPlayerCubit>().loadSong(song);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SongPlayerPage(songplayer: song);
                        },
                      ),
                    );
                  },
                  child: SizedBox(
                    width: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: 200,
                              width: double.infinity,
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.network(song.url, fit: BoxFit.cover),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: context.isDarkMode
                                            ? AppColors.darkGrey
                                            : Color(0xffE6E6E6),
                                      ),
                                      child: Icon(
                                        Icons.play_arrow,
                                        color: context.isDarkMode
                                            ? Color(0xff959595)
                                            : Color(0xff555555),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 13),
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Text(
                            song.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Text(song.artist),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is NewestSongsFailure) {
            return Text('Failed to load songs');
          }
          return Container();
        },
      ),
    );
  }
}
