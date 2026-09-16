import 'package:get/get.dart';
import '../../view/AdminPanel.dart';
import '../../services/accounts_services/login.dart';
import '../../models/token_response_model.dart';
import '../../controllers/accounts_controllers/refresh_controller.dart';
import '../../controllers/accounts_controllers/me_controller.dart';
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
      final TokenResponseModel response = await loginService.loginUser(
        phone: phone.value,
        password: password.value,
      );

      // ✅ Let RefreshController manage token + expiry + auto refresh
      final refreshController = Get.find<RefreshController>();
      await refreshController.startAutoRefresh(
        response.token,
        response.expiresIn,
      );

      // ✅ Load current user
      final meController = Get.find<MeController>();
      meController.errorMessage.value = '';
      await meController.getUser();

      Get.offAll(() => const AdminPanel());
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
