class UserModel {
  final String email;
  final String firstName;
  final String? accessToken;
  final String? refreshToken;
  final int? expiresIn;

  UserModel({
    required this.email,
    required this.firstName,
    this.accessToken,
    this.refreshToken,
    this.expiresIn,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] ?? '',
      firstName: json['first_name'] ?? '',
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      expiresIn: json['expires'],
    );
  }

  bool get isTokenValid => accessToken != null;
}
