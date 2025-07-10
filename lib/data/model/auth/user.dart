import 'package:flutter_spotify_application_1/domain/entities/auth/user.dart';

class UserModel {
  String? fullName;
  String? email;
  List<String>? favorites;

  UserModel({this.fullName, this.email, this.favorites});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['name'] as String?,
      email: json['email'] as String?,
      favorites: (json['favorites'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': fullName,
      'email': email,
      'favorites': favorites ?? [],
    };
  }
}

extension UserModelX on UserModel {
  UserEntity toEntity() {
    return UserEntity(fullName: fullName ?? '', email: email ?? '');
  }
}
