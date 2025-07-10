// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'newest_songs_cubit.dart';

@immutable
sealed class NewestSongsState {}

final class NewestSongsInitial extends NewestSongsState {}
final class NewestSongsLoading extends NewestSongsState { 
}
class NewestSongsLoaded extends NewestSongsState {
  final List<SongEntity> songs;
  NewestSongsLoaded({
    required this.songs,
  });
}

class NewestSongsFailure extends  NewestSongsState{
  
}