import 'package:dartz/dartz.dart';
import 'package:flutter_spotify_application_1/data/model/auth/create_user_request.dart';
import 'package:flutter_spotify_application_1/data/model/auth/signin_user_req.dart';

abstract class AuthRepository {
  Future<Either> signup(CreateUserRequest createUserRequest);
  Future<Either> signin(SigninUserReq  signinUserReq);
  Future<Either> getUser();
  Future<List<String>> getFavorites();
  Future<void> addFavorite(String itemId);
  Future<void> removeFavorite(String itemId);
}