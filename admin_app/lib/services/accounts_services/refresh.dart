import '../../assistant/api.dart';
import '../../models/token_response_model.dart';
import '../../assistant/api_config.dart';
import '../../assistant/api_exception.dart';

class Refresh {
  Future<TokenResponseModel> refreshToken({required String token}) async {
    final response = await Api().post(
      url: "$baseUrl/auth/refresh",
      token: token,
      body: null,
    );

    if (response is Map<String, dynamic>) {
      if (response["error"] != null) {
        throw ApiException(401, response["error"].toString());
      }
      return TokenResponseModel.fromJson(response);
    }

    throw ApiException(500, "Unexpected response format during token refresh");
  }
}
