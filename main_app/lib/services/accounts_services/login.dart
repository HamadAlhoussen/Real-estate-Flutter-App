import '../../assistant/api.dart';
import '../../assistant/api_config.dart';
import '../../assistant/api_exception.dart';

class Login {
  Future<dynamic> loginUser({
    required String phone,
    required String password,
  }) async {
    final response = await Api().post(
      url: "$baseUrl/auth/login",
      body: {"phone": phone, "password": password},
    );

    if (response is Map<String, dynamic> && response["error"] != null) {
      final error = response["error"];
      switch (error) {
        case "invalid_phone":
          throw ApiException(400, "invalid_phone");
        case "invalid_password":
          throw ApiException(401, "invalid_password");
        default:
          throw ApiException(500, "unexpected_error");
      }
    }

    return response;
  }
}
