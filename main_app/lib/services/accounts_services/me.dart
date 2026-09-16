import '../../assistant/api.dart';
import '../../models/user_account_model.dart';
import '../../assistant/api_config.dart';
import '../../assistant/api_exception.dart';

class Me {
  Future<UserAccountModel> getUser({required String token}) async {
    final response = await Api().get(url: "$baseUrl/auth/me", token: token);

    if (response is Map<String, dynamic>) {
      if (response["error"] != null) {
        throw ApiException(401, response["error"].toString());
      }
      return UserAccountModel.fromJson(response);
    }

    throw ApiException(500, "Unexpected response format while fetching user");
  }
}
