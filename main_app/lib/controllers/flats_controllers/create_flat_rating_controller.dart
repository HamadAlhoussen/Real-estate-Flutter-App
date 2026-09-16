import 'package:get/get.dart';
import '../../services/flats_services/create_flat_rating.dart';
import '../../assistant/api_exception.dart';
import '../accounts_controllers/refresh_controller.dart';

class CreateFlatRatingController extends GetxController {
  var isLoading = false.obs;
  var response = {}.obs;
  var errorMessage = ''.obs;

  Future<void> rateFlat({
    required int flatId,
    required int rating,
    required String token,
  }) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final token = Get.find<RefreshController>().token.value;
      final result = await CreateFlatRating().rate(
        flatId: flatId,
        rating: rating,
        token: token,
      );
      response.value = result;
      Get.snackbar("Success", "Flat rated successfully");
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
