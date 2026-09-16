import 'package:get/get.dart';
import '../../models/user_account_model.dart';
import '../../services/accounts_services/me.dart';
import 'refresh_controller.dart';
import '../../utils/app_preferances.dart';
import '../../assistant/api_exception.dart';
// import '../../services/firebase/firebase_user_service.dart';

// final firebaseUserService = FirebaseUserService();

class MeController extends GetxController {
  var user = Rxn<UserAccountModel>();
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> getUser() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final refreshController = Get.find<RefreshController>();
      final currentToken = refreshController.token.value;

      if (currentToken.isEmpty) {
        errorMessage.value = 'No valid token found';
        print("MeController error: No valid token found");
        Get.snackbar("Error", "No valid token found");
        return;
      }

      final expiry = await AppPreferences.getTokenExpiry();
      if (expiry == null || DateTime.now().isAfter(expiry)) {
        await AppPreferences.clearToken();
        refreshController.token.value = '';
        errorMessage.value = 'Token expired';
        print("MeController error: Token expired");
        Get.snackbar("Error", "Your session has expired, please log in again");
        return;
      }

      final meService = Me();
      final response = await meService.getUser(token: currentToken);
      user.value = response;
      // await firebaseUserService.syncUser(response);

    } on ApiException catch (e) {
      errorMessage.value = e.message;
      print("MeController ApiException: ${e.message}");
      Get.snackbar("Error", e.message);
    } catch (e) {
      errorMessage.value = 'Failed to get user: $e';
      print("MeController error: ${e.toString()}");
      Get.snackbar("Error", "Failed to load user information");
    } finally {
      isLoading.value = false;
    }
  }
}
