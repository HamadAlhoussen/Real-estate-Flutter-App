import '../../assistant/api.dart';
import '../../assistant/api_config.dart';
import '../../assistant/api_exception.dart';

class ResetPasswordService {
  Future<dynamic> resetPassword({
    required String phone,
    required String otpCode,
    required String password,
    required String passwordConfirmation,
  }) async {
    final response = await Api().patch(
      url: "$baseUrl/auth/resetPassword",
      fields: {
        "phone": phone,
        "otp_code": otpCode,
        "password": password,
        "password_confirmation": passwordConfirmation,
      },
    );

    if (response is Map<String, dynamic> && response["error"] != null) {
      throw ApiException(400, response["error"]);
    }

    return response;
  }
}
