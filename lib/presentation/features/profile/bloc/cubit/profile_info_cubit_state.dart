part of 'profile_info_cubit_cubit.dart';

@immutable
sealed class ProfileInfoCubitState {}

final class ProfileInfoCubitInitial extends ProfileInfoCubitState {}
final class ProfileInfoCubitLoading extends ProfileInfoCubitState {}
final class ProfileInfoCubitLoaded extends ProfileInfoCubitState {
  final UserEntity user;

  ProfileInfoCubitLoaded({required this.user});
}
final class ProfileInfoCubitFailure extends ProfileInfoCubitState {
  final String message;

  ProfileInfoCubitFailure({required this.message});
}
