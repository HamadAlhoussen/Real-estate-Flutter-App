import '../../assistant/api.dart';
import '../../assistant/api_config.dart';
import '../../assistant/api_exception.dart';
import '../../models/token_response_model.dart';

class OtpService {
  Future<TokenResponseModel> verifyOtp({
    required String phone,
    required String otp_code,
  }) async {
    final response = await Api().post(
      url: "$baseUrl/otp",
      body: {"phone": phone, "otp_code": otp_code},
    );

    if (response is Map<String, dynamic> && response["error"] != null) {
      throw ApiException(401, response["error"].toString());
    }

    return TokenResponseModel.fromJson(response);
  }
}
