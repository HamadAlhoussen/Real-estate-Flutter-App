import 'package:get/get.dart';
import '../../services/flats_services/delete_flat.dart';
import '../../controllers/accounts_controllers/refresh_controller.dart';
import '../../assistant/api_exception.dart';

class DeleteFlatController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var deleteResult = <String, dynamic>{}.obs;

  Future<void> deleteFlat(int id) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final token = Get.find<RefreshController>().token.value;
      final service = DeleteFlat();
      final response = await service.delete(id: id, token: token);
      deleteResult.assignAll(response);
      Get.snackbar("Success", "Flat deleted successfully");
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
}
