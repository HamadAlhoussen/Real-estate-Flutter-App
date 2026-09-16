import 'package:get/get.dart';
import '../../services/admin_services/approve_user.dart';
import '../../assistant/api_exception.dart';

class ApproveUserController extends GetxController {
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  final _service = ApproveUserService();

  Future<void> approveUser(int userId) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      await _service.approveUser(userId);
      Get.snackbar("Success", "User approved successfully");
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
