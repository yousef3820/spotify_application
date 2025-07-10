part of 'favourites_cubit_cubit.dart';

@immutable
sealed class FavoritesCubitState {}

final class FavoritesCubitInitial extends FavoritesCubitState {}
final class FavoritesCubitLoading extends FavoritesCubitState {}
final class FavoritesCubitLoaded extends FavoritesCubitState {
  final List<String> favorites;
  final Map<String, SongEntity> favoriteSongs; // Add this to store song details

  FavoritesCubitLoaded({required this.favorites ,     required this.favoriteSongs,});
}
final class FavoritesCubitFailure extends FavoritesCubitState {
  final String message;

  FavoritesCubitFailure({required this.message});
}
