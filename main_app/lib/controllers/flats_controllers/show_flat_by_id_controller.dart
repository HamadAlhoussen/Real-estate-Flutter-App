import 'package:get/get.dart';
import '../../models/flat_model.dart';
import '../../services/flats_services/show_flat_by_id.dart';
import '../../controllers/accounts_controllers/refresh_controller.dart';
import '../../assistant/api_exception.dart';

class ShowFlatByIdController extends GetxController {
  var flat = Rxn<FlatModel>();
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  final _service = ShowFlatById();

  Future<void> fetchFlatById(int id) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final token = Get.find<RefreshController>().token.value;
      final result = await _service.getFlat(id: id, token: token);
      flat.value = result;
      if (flat.value == null) {
        Get.snackbar("Notice", "No flat found with ID $id");
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
