import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../assistant/api_exception.dart';
import '../../services/accounts_services/reset_password.dart';
import '../../view/LoginScreen.dart';

class ResetPasswordController extends GetxController {
  final ResetPasswordService _service = ResetPasswordService();

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  var password = ''.obs;
  var passwordConfirmation = ''.obs;

  Future<void> resetPassword({
    required String phone,
    required String otpCode,
    required String password,
    required String passwordConfirmation,
  }) async {
    if (password.length < 8) {
      errorMessage.value = "Password must be at least 8 characters";
      return;
    }

    if (password != passwordConfirmation) {
      errorMessage.value = "Passwords do not match";
      return;
    }

    try {
      isLoading.value = true;
      errorMessage.value = '';

      await _service.resetPassword(
        phone: phone,
        otpCode: otpCode,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );

      Get.dialog(
        AlertDialog(
          title: const Text("Password Reset"),
          content: const Text("Your password has been reset successfully."),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
                Get.offAll(() => LoginScreen());
              },
              child: const Text("OK"),
            ),
          ],
        ),
        barrierDismissible: false,
      );
    } on ApiException catch (e) {
      errorMessage.value = e.message;
      Get.snackbar("Reset Failed", e.message);
    } catch (_) {
      errorMessage.value = "Unexpected error occurred";
      Get.snackbar("Reset Failed", "Unexpected error occurred");
    } finally {
      isLoading.value = false;
    }
  }
}
