import '../../assistant/api.dart';
import '../../assistant/api_config.dart';

class Register {
  Future<void> addUser({
    required String firstName,
    required String lastName,
    required String phone,
    required String password,
    required String passwordConfirmation,
    required String avatarPath,
    required DateTime birthDate,
    required String idCardPath,
  }) async {
    final formattedBirthDate =
        "${birthDate.year.toString().padLeft(4, '0')}-"
        "${birthDate.month.toString().padLeft(2, '0')}-"
        "${birthDate.day.toString().padLeft(2, '0')}";

    await Api().postMultipart(
      url: "$baseUrl/auth/register",
      fields: {
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "password": password,
        "password_confirmation": passwordConfirmation,
        "birth_date": formattedBirthDate,
      },
      files: {"avatar_path": avatarPath, "id_card_path": idCardPath},
    );
  }
}
