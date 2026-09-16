import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import '../../models/user_account_model.dart';
import '../../services/accounts_services/update_user.dart';
import '../../assistant/api_exception.dart';

class UpdateUserController extends GetxController {
  var isLoading = false.obs;
  var user = Rxn<UserAccountModel>();
  var updatedAvatarPath = ''.obs;
  var errorMessage = ''.obs;

  /// Update user info, including optional birthDate
  Future<void> updateUser({
    required String token,
    String? firstName,
    String? lastName,
    String? phone,
    String? avatarPath,
    DateTime? birthDate, // <-- added
  }) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final result = await UpdateUser().update(
        token: token,
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        avatarPath: avatarPath ?? updatedAvatarPath.value,
        birthDate: birthDate, // <-- pass optional birthDate
      );
      user.value = result;
      Get.snackbar("Success", "User updated successfully");
    } on ApiException catch (e) {
      errorMessage.value = e.message;
      Get.snackbar("Error", e.message);
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar("Error", "Unexpected error occurred");
    } finally {
      isLoading.value = false;
    }
  }

  /// Pick avatar image
  Future<void> updateAvatar() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg'],
    );
    if (result != null && result.files.isNotEmpty) {
      final file = result.files.single;
      if (file.size > 10 * 1024 * 1024) {
        Get.snackbar("Error", "Avatar image must be less than 10 MB");
        return;
      }
      updatedAvatarPath.value = file.path ?? '';
    }
  }
}
