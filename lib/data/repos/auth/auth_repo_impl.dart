import 'package:dartz/dartz.dart';
import 'package:flutter_spotify_application_1/data/datasource/auth/auth_firebase_service.dart';
import 'package:flutter_spotify_application_1/data/model/auth/create_user_request.dart';
import 'package:flutter_spotify_application_1/data/model/auth/signin_user_req.dart';
import 'package:flutter_spotify_application_1/domain/repos/auth/auth_repo.dart';
import 'package:flutter_spotify_application_1/serviceLocator.dart';

class AuthRepoImpl extends AuthRepository {
  @override
  Future<Either> signin(SigninUserReq signinUserReq) async {
    return await sl<AuthFirebaseService>().signin(signinUserReq);
  }

  @override
  Future<Either> signup(CreateUserRequest createUserRequest) async {
    return await sl<AuthFirebaseService>().signup(createUserRequest);
  }

  @override
  Future<Either> getUser() async {
    return await sl<AuthFirebaseService>().getUser();
  }

  @override
  Future<void> addFavorite(String itemId) async {
   await sl<AuthFirebaseService>().addFavorite(itemId);
  }

  @override
  Future<List<String>> getFavorites() async {
    return await sl<AuthFirebaseService>().getFavorites();
  }

  @override
  Future<void> removeFavorite(String itemId) async {
    // TODO: implement removeFavorite
   await sl<AuthFirebaseService>().removeFavorite(itemId);
  }
}
