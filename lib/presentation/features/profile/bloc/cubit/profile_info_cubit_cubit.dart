import 'package:bloc/bloc.dart';
import 'package:flutter_spotify_application_1/domain/entities/auth/user.dart';
import 'package:flutter_spotify_application_1/domain/usecases/getuser_usecase.dart';
import 'package:flutter_spotify_application_1/serviceLocator.dart';
import 'package:meta/meta.dart';

part 'profile_info_cubit_state.dart';

class ProfileInfoCubitCubit extends Cubit<ProfileInfoCubitState> {
  ProfileInfoCubitCubit() : super(ProfileInfoCubitInitial());
  Future<void> getUser() async {
    try {
      print('Fetching user...');
      var user = await sl<GetUserUseCase>().execute();
      user.fold(
        (failure) {
          print('Failure: ${failure.message}');
          emit(ProfileInfoCubitFailure(message: failure.message));
        },
        (user) {
          print('User loaded: ${user.fullName}');
          emit(ProfileInfoCubitLoaded(user: user));
        },
      );
    } catch (e) {
      print('Unexpected error: $e');
      emit(ProfileInfoCubitFailure(message: e.toString()));
    }
  }
}
