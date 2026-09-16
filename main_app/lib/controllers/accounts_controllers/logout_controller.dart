import 'package:get/get.dart';
import '../../services/accounts_services/logout.dart';
import '../../controllers/accounts_controllers/refresh_controller.dart';
import '../../controllers/accounts_controllers/me_controller.dart';
import '../../view/LoginScreen.dart';
import '../../utils/app_preferances.dart';
import '../../assistant/api_exception.dart';

class LogoutController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> logout() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final refreshController = Get.find<RefreshController>();
      final token = refreshController.token.value;

      if (token.isNotEmpty) {
        final logoutService = Logout();
        await logoutService.logout(token: token);
      }

      refreshController.token.value = '';
      final meController = Get.find<MeController>();
      meController.user.value = null;

      await AppPreferences.clearToken();

      Get.offAll(() => const LoginScreen());
      Get.snackbar("Success", "You have been logged out");
    } on ApiException catch (e) {
      errorMessage.value = e.message;
      Get.snackbar("Logout Failed", e.message);
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar("Logout Failed", "Unexpected error occurred");
    } finally {
      isLoading.value = false;
    }
  }
}
