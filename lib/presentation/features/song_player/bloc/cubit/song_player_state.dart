part of 'song_player_cubit.dart';

@immutable
sealed class SongPlayerState {}

final class SongPlayerInitial extends SongPlayerState {}
final class SongPlayerLoading extends SongPlayerState {}
final class SongPlayerFailure extends SongPlayerState {}
final class SongPlayerLoaded extends SongPlayerState {}
