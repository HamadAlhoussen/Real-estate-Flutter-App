class TokenResponseModel {
  final String token;
  final int expiresIn;

  TokenResponseModel({required this.token, required this.expiresIn});

  factory TokenResponseModel.fromJson(Map<String, dynamic> json) {
    return TokenResponseModel(
      token: json["token"],
      expiresIn: json["expires_in"],
    );
  }
}
