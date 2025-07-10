class UserEntity {
  final String? fullName;
  final String? email;
  final List<String>? favorites;

  UserEntity({this.fullName, this.email, this.favorites});

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      fullName: json['name'] as String?,
      email: json['email'] as String?,
      favorites:
          (json['favorites'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': fullName, 'email': email, 'favorites': favorites ?? []};
  }
}
