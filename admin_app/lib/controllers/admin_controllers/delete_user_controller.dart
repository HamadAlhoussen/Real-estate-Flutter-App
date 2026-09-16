import 'package:get/get.dart';
import '../../services/admin_services/delete_user.dart';
import '../../assistant/api_exception.dart';

class DeleteUserController extends GetxController {
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  final _service = DeleteUserService();

  Future<void> deleteUser(int userId) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      await _service.deleteUser(userId);
      Get.snackbar("Success", "User deleted successfully");
    } on ApiException catch (e) {
      errorMessage.value = e.message;
      Get.snackbar("Error", e.message);
    } catch (_) {
      Get.snackbar("Error", "Unexpected error occurred");
    } finally {
      isLoading.value = false;
    }
  }
}
