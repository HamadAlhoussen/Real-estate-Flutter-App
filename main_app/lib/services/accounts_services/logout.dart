import '../../assistant/api.dart';
import '../../assistant/api_config.dart';
import '../../assistant/api_exception.dart';

class Logout {
  Future<Map<String, dynamic>> logout({required String token}) async {
    final response = await Api().post(
      url: "$baseUrl/auth/logout",
      token: token,
    );

    if (response is Map<String, dynamic>) {
      if (response["error"] != null) {
        throw ApiException(401, response["error"].toString());
      }
      return response;
    }

    throw ApiException(500, "Unexpected response format during logout");
  }
}
