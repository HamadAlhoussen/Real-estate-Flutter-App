import '../../assistant/api.dart';
import '../../assistant/api_config.dart';
import '../../assistant/api_exception.dart';

class VerifyOtpService {
  Future<dynamic> verifyOtp({
    required String phone,
    required String otpCode,
  }) async {
    final response = await Api().post(
      url: "$baseUrl/verifyOtp",
      body: {"phone": phone, "otp_code": otpCode},
    );

    if (response is Map<String, dynamic> && response["error"] != null) {
      throw ApiException(400, response["error"]);
    }

    return response;
  }
}
