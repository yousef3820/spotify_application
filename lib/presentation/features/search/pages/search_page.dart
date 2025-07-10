// presentation/features/search/pages/search_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spotify_application_1/common/widgets/appbar/app_bar.dart';
import 'package:flutter_spotify_application_1/core/configs/theme/app_colors.dart';
import 'package:flutter_spotify_application_1/presentation/features/search/bloc/cubit/search_cubit.dart';
import 'package:flutter_spotify_application_1/presentation/features/song_player/bloc/cubit/song_player_cubit.dart';
import 'package:flutter_spotify_application_1/presentation/features/song_player/pages/song_player_page.dart';
import 'package:flutter_spotify_application_1/presentation/features/song_player/widgets/mini_player.dart';
import 'package:flutter_spotify_application_1/serviceLocator.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SearchCubit>(),
      child: Scaffold(
        bottomNavigationBar: BlocBuilder<SongPlayerCubit, SongPlayerState>(
          builder: (context, state) {
            return MiniPlayer();
          },
        ),
        appBar: BasicAppBar(title: const Text('Search Songs')),
        body: Column(
          children: [
            const SearchBar(),
            Expanded(child: SearchResults()),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search for songs...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
        ),
        onChanged: (query) {
          context.read<SearchCubit>().searchSongs(query);
        },
      ),
    );
  }
}

class SearchResults extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchInitial) {
          return const Center(child: Text('Start typing to search songs'));
        }
        if (state is SearchLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }
        if (state is SearchError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        if (state is SearchLoaded) {
          if (state.songs.isEmpty) {
            return const Center(child: Text('No songs found'));
          }
          return ListView.builder(
            itemCount: state.songs.length,
            itemBuilder: (context, index) {
              final song = state.songs[index];
              return ListTile(
                leading: const Icon(Icons.music_note),
                title: Text(song.title),
                subtitle: Text(song.artist),
                onTap: () {
                  context.read<SongPlayerCubit>().loadSong(song);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SongPlayerPage(songplayer: song),
                    ),
                  );
                },
              );
            },
          );
        }
        return Container();
      },
    );
  }
}
