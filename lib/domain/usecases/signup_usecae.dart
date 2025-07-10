import 'package:dartz/dartz.dart';
import 'package:flutter_spotify_application_1/core/configs/usecase/usecase.dart';
import 'package:flutter_spotify_application_1/data/model/auth/create_user_request.dart';
import 'package:flutter_spotify_application_1/domain/repos/auth/auth_repo.dart';
import 'package:flutter_spotify_application_1/serviceLocator.dart';

class SignupUsecae implements Usecase <Either,CreateUserRequest> {
  @override
  Future<Either> execute({CreateUserRequest? params}) {
  if (params == null) {
    throw ArgumentError('params cannot be null');
  }
    return sl<AuthRepository>().signup(params);
  }
}
