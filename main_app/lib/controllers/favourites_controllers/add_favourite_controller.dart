import 'package:get/get.dart';
import '../../services/favourites_services/add_favourite.dart';
import '../../assistant/api_exception.dart';
import '../../utils/app_preferances.dart';

class AddFavouriteController extends GetxController {
  final _service = AddFavouriteService();

  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var result = <String, dynamic>{}.obs;

  Future<void> addFavourite(int flatId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final token = await AppPreferences.getToken();
      if (token == null || token.isEmpty) {
        errorMessage.value = "No valid token found";
        return;
      }

      final response = await _service.addFavourite(
        token: token,
        flatId: flatId,
      );
      result.value = response;
      Get.snackbar("Success", "Added to favourites");
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
