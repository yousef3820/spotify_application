// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'play_list_cubit.dart';

@immutable
sealed class PlayListState {}

final class PlayListInitial extends PlayListState {}
final class PlayListLoading extends PlayListState { 
}
class PlayListLoaded extends PlayListState {
  final List<SongEntity> songs;
  PlayListLoaded({
    required this.songs,
  });
}

class PlayListFailure extends  PlayListState{
  
}