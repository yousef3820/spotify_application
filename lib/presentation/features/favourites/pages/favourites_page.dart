import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spotify_application_1/common/widgets/appbar/app_bar.dart';
import 'package:flutter_spotify_application_1/core/configs/theme/app_colors.dart';
import 'package:flutter_spotify_application_1/domain/entities/song/song.dart';
import 'package:flutter_spotify_application_1/presentation/features/favourites/bloc/favourites_cubit_cubit.dart';
import 'package:flutter_spotify_application_1/presentation/features/favourites/widgets/buildEmptyState.dart';
import 'package:flutter_spotify_application_1/presentation/features/song_player/bloc/cubit/song_player_cubit.dart';
import 'package:flutter_spotify_application_1/presentation/features/song_player/pages/song_player_page.dart';
import 'package:flutter_spotify_application_1/presentation/features/song_player/widgets/mini_player.dart';

class FavoritesWidget extends StatelessWidget {
  const FavoritesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocConsumer<FavoritesCubit, FavoritesCubitState>(
      listener: (context, state) {
        if (state is FavoritesCubitFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is FavoritesCubitInitial || state is FavoritesCubitLoading) {
          return Scaffold(
            appBar: BasicAppBar(title: const Text('My Favorites')),
            body: const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          );
        }

        if (state is FavoritesCubitLoaded) {
          return Scaffold(
            bottomNavigationBar: BlocBuilder<SongPlayerCubit, SongPlayerState>(
              builder: (context, state) {
                return MiniPlayer();
              },
            ),
            appBar: BasicAppBar(title: const Text('My Favorites')),
            body: state.favoriteSongs.isEmpty
                ? buildEmptyState(theme)
                : _buildFavoritesList(context, state, theme, isDark),
          );
        }

        if (state is FavoritesCubitFailure) {
          return Scaffold(
            appBar: BasicAppBar(title: const Text('My Favorites')),
            body: _buildErrorState(context, state, theme),
          );
        }

        return Scaffold(
          appBar: BasicAppBar(title: const Text('My Favorites')),
          body: const Center(child: Text('Unknown state')),
        );
      },
    );
  }

  

  Widget _buildFavoritesList(
    BuildContext context,
    FavoritesCubitLoaded state,
    ThemeData theme,
    bool isDark,
  ) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            '${state.favoriteSongs.length} favorite songs',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha:  0.7),
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: state.favoriteSongs.length,
            separatorBuilder: (context, index) =>
                Divider(height: 1, color: theme.dividerColor.withValues(alpha:  0.1)),
            itemBuilder: (context, index) {
              final songUrl = state.favorites[index];
              final song = state.favoriteSongs[songUrl];
              if (song == null) return const SizedBox.shrink();

              return _buildFavoriteItem(context, song, theme, isDark);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFavoriteItem(
    BuildContext context,
    SongEntity song,
    ThemeData theme,
    bool isDark,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: isDark
            ? const Color.fromRGBO(158, 158, 158, 0.1)
            : const Color.fromRGBO(158, 158, 158, 0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: NetworkImage(song.url),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          song.title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          song.artist,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha:  0.7),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          icon: Icon(Icons.favorite, color: AppColors.primary, size: 28),
          onPressed: () =>
              context.read<FavoritesCubit>().removeFromFavorites(song.url),
        ),
        onTap: () {
          context.read<SongPlayerCubit>().loadSong(song);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SongPlayerPage(songplayer: song),
            ),
          );
        },
      ),
    );
  }

  Widget _buildErrorState(
    BuildContext context,
    FavoritesCubitFailure state,
    ThemeData theme,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: theme.colorScheme.error, size: 60),
            const SizedBox(height: 20),
            Text(
              'Failed to load favorites',
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              state.message,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              onPressed: () => context.read<FavoritesCubit>().loadFavorites(),
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}
