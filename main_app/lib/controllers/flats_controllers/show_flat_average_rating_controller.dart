import 'package:get/get.dart';
import '../../services/flats_services/show_flat_average_rating.dart';
import '../../assistant/api_exception.dart';
import '../accounts_controllers/refresh_controller.dart';

class ShowFlatAverageRatingController extends GetxController {
  var isLoading = false.obs;
  var averageRating = 0.0.obs;
  var errorMessage = ''.obs;

  Future<void> fetchAverageRating({required int flatId}) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final token = Get.find<RefreshController>().token.value;
      final result = await ShowFlatAverageRating().fetch(
        flatId: flatId,
        token: token,
      );
      averageRating.value = result;
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
