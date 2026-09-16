import '../../assistant/api.dart';
import '../../models/user_account_model.dart';
import '../../assistant/api_config.dart';
import '../../assistant/api_exception.dart';

class UpdateUser {
  Future<UserAccountModel> update({
    required String token,
    String? firstName,
    String? lastName,
    String? phone,
    String? avatarPath,
    DateTime? birthDate,
  }) async {
    final Map<String, String> fields = {};
    if (firstName != null) fields['first_name'] = firstName;
    if (lastName != null) fields['last_name'] = lastName;
    if (phone != null) fields['phone'] = phone;

    if (birthDate != null) fields['birth_date'] = birthDate.toIso8601String();

    final Map<String, String> files = {};
    if (avatarPath != null && avatarPath.isNotEmpty) {
      files['avatar_path'] = avatarPath;
    }

    final response = await Api().postMultipart(
      url: "$baseUrl/auth/update",
      token: token,
      fields: fields,
      files: files,
    );

    if (response is Map<String, dynamic>) {
      if (response["error"] != null) {
        throw ApiException(400, response["error"].toString());
      }
      return UserAccountModel.fromJson(response);
    }

    throw ApiException(500, "Unexpected response format during user update");
  }
}
