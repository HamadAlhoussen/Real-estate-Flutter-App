import 'dart:io';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import '../../view/LoginScreen.dart';
import '../../services/accounts_services/register.dart';
import '../../assistant/api_exception.dart';

class RegisterController extends GetxController {
  var isLoading = false.obs;
  var firstName = ''.obs;
  var lastName = ''.obs;
  var phone = ''.obs;
  var password = ''.obs;
  var passwordConfirmation = ''.obs;
  var avatarPath = ''.obs;
  var idCardPath = ''.obs;
  var birthDate = Rxn<DateTime>();
  var errorMessage = ''.obs;

  void setBirthDate(DateTime date) {
    birthDate.value = date;
  }

  Future<void> pickIdCard() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg'],
    );
    if (result != null && result.files.isNotEmpty) {
      final file = result.files.single;
      if (file.size > 10 * 1024 * 1024) {
        Get.snackbar("Error", "ID Card image must be less than 10 MB");
        return;
      }
      if (file.path != null && file.path!.isNotEmpty) {
        idCardPath.value = file.path!;
      } else {
        Get.snackbar("Error", "Invalid ID Card file path");
      }
    }
  }

  Future<void> pickAvatar() async {
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
      if (file.path != null && file.path!.isNotEmpty) {
        avatarPath.value = file.path!;
      } else {
        Get.snackbar("Error", "Invalid Avatar file path");
      }
    }
  }

  Future<void> register({
    required String firstName,
    required String lastName,
    required String phone,
    required String password,
    required String passwordConfirmation,
    required String avatarPath,
    required String idCardPath,
  }) async {
    if (firstName.isEmpty ||
        lastName.isEmpty ||
        phone.isEmpty ||
        password.isEmpty ||
        passwordConfirmation.isEmpty ||
        avatarPath.isEmpty ||
        idCardPath.isEmpty ||
        birthDate.value == null) {
      Get.snackbar("Error", "All fields are required");
      return;
    }

    if (!File(avatarPath).existsSync() || !File(idCardPath).existsSync()) {
      Get.snackbar("Error", "Selected images could not be found");
      return;
    }

    final phoneRegex = RegExp(r'^\+?[0-9]{9,15}$');
    if (!phoneRegex.hasMatch(phone)) {
      Get.snackbar("Error", "Phone number must be 9–15 digits and may start with +");
      return;
    }

    if (password.length < 8) {
      Get.snackbar("Error", "Password must be at least 8 characters");
      return;
    }

    if (password != passwordConfirmation) {
      Get.snackbar("Error", "Passwords do not match");
      return;
    }

    final minAgeDate = DateTime.now().subtract(const Duration(days: 365 * 16));
    if (birthDate.value!.isAfter(minAgeDate)) {
      Get.snackbar("Error", "You must be at least 16 years old");
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';
    try {
      final registerService = Register();
      await registerService.addUser(
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        password: password,
        passwordConfirmation: passwordConfirmation,
        avatarPath: avatarPath,
        birthDate: birthDate.value!,
        idCardPath: idCardPath,
      );

      Get.snackbar("Success", "Account created. Please log in.");
      Get.to(() => const LoginScreen());
    } on ApiException catch (e) {
      errorMessage.value = e.message;
      Get.snackbar("Registration Failed", e.message);
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar("Registration Failed", errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }
}