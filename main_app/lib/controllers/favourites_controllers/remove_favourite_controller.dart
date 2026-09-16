import 'package:get/get.dart';
import '../../services/favourites_services/remove_favourite.dart';
import '../../assistant/api_exception.dart';
import '../../utils/app_preferances.dart';

class RemoveFavouriteController extends GetxController {
  final _service = RemoveFavouriteService();

  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var result = <String, dynamic>{}.obs;

  Future<void> removeFavourite(int flatId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final token = await AppPreferences.getToken();
      if (token == null || token.isEmpty) {
        errorMessage.value = "No valid token found";
        return;
      }

      final response = await _service.removeFavourite(
        token: token,
        flatId: flatId,
      );
      result.value = response;
      Get.snackbar("Success", "Removed from favourites");
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
