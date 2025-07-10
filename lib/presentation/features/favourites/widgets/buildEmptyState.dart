import 'package:flutter/material.dart';
import 'package:flutter_spotify_application_1/core/configs/theme/app_colors.dart';

Widget buildEmptyState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border_rounded,
            color: AppColors.primary,
            size: 100,
          ),
          const SizedBox(height: 16),
          Text(
            'No favorites yet',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha:  0.6),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap the heart icon to add songs to your favorites',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha:  0.5),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }