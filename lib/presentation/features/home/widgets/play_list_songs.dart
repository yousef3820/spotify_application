import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spotify_application_1/common/helpers/is_dark_mode.dart';
import 'package:flutter_spotify_application_1/core/configs/theme/app_colors.dart';
import 'package:flutter_spotify_application_1/domain/entities/song/song.dart';
import 'package:flutter_spotify_application_1/presentation/features/favourites/bloc/favourites_cubit_cubit.dart';
import 'package:flutter_spotify_application_1/presentation/features/home/bloc/cubit/play_list_cubit.dart';
import 'package:flutter_spotify_application_1/presentation/features/song_player/bloc/cubit/song_player_cubit.dart';
import 'package:flutter_spotify_application_1/presentation/features/song_player/pages/song_player_page.dart';

class PlayListSongs extends StatelessWidget {
  const PlayListSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlayListCubit()..getPlayList(),
      child: BlocBuilder<PlayListCubit, PlayListState>(
        builder: (context, state) {
          if (state is PlayListLoading) {
            return SliverToBoxAdapter(
              child: Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            );
          }
          if (state is PlayListLoaded) {
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => SongItem(song: state.songs[index]),
                childCount: state.songs.length,
              ),
            );
          }
          if (state is PlayListFailure) {
            return SliverToBoxAdapter(child: Text('Failed to load songs'));
          }
          return SliverToBoxAdapter(child: Container());
        },
      ),
    );
  }
}

class SongItem extends StatelessWidget {
  final SongEntity song;

  const SongItem({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    final isFavorite = context.select<FavoritesCubit, bool>((cubit) {
      final state = cubit.state;
      if (state is FavoritesCubitLoaded) {
        return state.favorites.contains(song.url);
      }
      return false;
    });
    return GestureDetector(
      onTap: () {
        context.read<SongPlayerCubit>().loadSong(song);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SongPlayerPage(songplayer: song),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
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
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    song.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(song.artist),
                ],
              ),
            ),
            Text(song.duration.toString().replaceAll(".", ":")),
            SizedBox(width: 16),
            IconButton(
              onPressed: () async {
                final cubit = context.read<FavoritesCubit>();
                if (isFavorite) {
                  await cubit.removeFromFavorites(song.url);
                  _showSnackBar(
                    context,
                    icon: Icon(
                      Icons.heart_broken,
                      color: AppColors.primary,
                      size: 30,
                    ),
                    message: "Removed from favourites",
                    color: const Color.fromARGB(255, 210, 84, 75),
                  );
                } else {
                  await cubit.addToFavorites(song.url);
                  _showSnackBar(
                    context,
                    icon: Icon(
                      Icons.favorite,
                      color: AppColors.primary,
                      size: 30,
                    ),
                    message: "Added to favourites",
                    color: AppColors.grey,
                  );
                }
              },
              icon: Icon(
                Icons.favorite,
                size: 30,
                color: isFavorite ? AppColors.primary : Color(0xffb4b4b4),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(
    BuildContext context, {
    required Icon icon,
    required String message,
    required Color color,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
            SizedBox(width: 20),
            Text(
              message,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: color,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
