import 'package:get/get.dart';
import '../../view/OTPScreen.dart';
import '../../services/accounts_services/login.dart';
import '../../assistant/api_exception.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  var phone = ''.obs;
  var password = ''.obs;
  var errorMessage = ''.obs;

  Future<void> login() async {
    if (phone.value.isEmpty || password.value.isEmpty) {
      Get.snackbar("Login Error", "Phone and password are required");
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final loginService = Login();
      final response = await loginService.loginUser(
        phone: phone.value,
        password: password.value,
      );

      if (response is Map<String, dynamic> &&
          response['message'] == "Your account is pending until approval") {
        Get.snackbar("Pending Approval", response['message']);
        return;
      }

      Get.to(() => OtpScreen(), arguments: {"phone": phone.value});
    } on ApiException catch (e) {
      errorMessage.value = e.message;

      if (e.message == "invalid_phone") {
        Get.snackbar("Login Error", "Please enter a valid phone number");
      } else if (e.message == "invalid_password") {
        Get.snackbar("Login Error", "Invalid password");
      } else {
        Get.snackbar("Login Failed", e.message);
      }
    } catch (_) {
      errorMessage.value = "Unexpected error occurred";
      Get.snackbar("Login Failed", "Unexpected error occurred");
    } finally {
      isLoading.value = false;
    }
  }
}
