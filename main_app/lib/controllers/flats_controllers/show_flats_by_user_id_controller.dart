import 'package:get/get.dart';
import '../../models/flat_model.dart';
import '../../services/flats_services/show_flats_by_user_id.dart';
import '../../controllers/accounts_controllers/refresh_controller.dart';
import '../../assistant/api_exception.dart';

class ShowFlatsByUserIdController extends GetxController {
  var flats = <FlatModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> fetchFlatsByUserId() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final token = Get.find<RefreshController>().token.value;
      final service = ShowFlatsByUserId();
      flats.clear();

      final response = await service.getFlats(token: token);
      flats.assignAll(response);

      if (flats.isEmpty) {
        Get.snackbar("Notice", "No flats found for this user");
      }
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
