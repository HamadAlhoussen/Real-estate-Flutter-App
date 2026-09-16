import '../../assistant/api.dart';
import '../../assistant/api_config.dart';
import '../../assistant/api_exception.dart';

class ForgotPasswordService {
  Future<dynamic> sendOtp({required String phone}) async {
    final response = await Api().post(
      url: "$baseUrl/auth/forgetPassword",
      body: {"phone": phone},
    );

    if (response is Map<String, dynamic> && response["error"] != null) {
      throw ApiException(400, response["error"]);
    }

    return response;
  }
}
