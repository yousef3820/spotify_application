import 'package:dartz/dartz.dart';
import 'package:flutter_spotify_application_1/core/configs/usecase/usecase.dart';
import 'package:flutter_spotify_application_1/domain/repos/auth/auth_repo.dart';
import 'package:flutter_spotify_application_1/serviceLocator.dart';

class GetUserUseCase implements Usecase <Either,dynamic> {
  @override
  Future<Either> execute({params})  async{
    return sl<AuthRepository>().getUser();
  }
}
