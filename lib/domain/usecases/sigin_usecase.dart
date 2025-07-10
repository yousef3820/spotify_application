import 'package:dartz/dartz.dart';
import 'package:flutter_spotify_application_1/core/configs/usecase/usecase.dart';
import 'package:flutter_spotify_application_1/data/model/auth/signin_user_req.dart';
import 'package:flutter_spotify_application_1/domain/repos/auth/auth_repo.dart';
import 'package:flutter_spotify_application_1/serviceLocator.dart';

class SiginUsecase implements Usecase <Either,SigninUserReq> {
  @override
  Future<Either> execute({SigninUserReq? params}) {
  if (params == null) {
    throw ArgumentError('params cannot be null');
  }
    return sl<AuthRepository>().signin(params);
  }
}
