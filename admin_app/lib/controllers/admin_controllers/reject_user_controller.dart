import 'package:get/get.dart';
import '../../services/admin_services/reject_user.dart';
import '../../assistant/api_exception.dart';

class RejectUserController extends GetxController {
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  final _service = RejectUserService();

  Future<void> rejectUser(int userId) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      await _service.rejectUser(userId);
      Get.snackbar("Success", "User rejected successfully");
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
