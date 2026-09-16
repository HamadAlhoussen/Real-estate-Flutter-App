import 'package:get/get.dart';
import '../../services/favourites_services/show_favourites.dart';
import '../../assistant/api_exception.dart';
import '../../utils/app_preferances.dart';

class ShowFavouritesController extends GetxController {
  final _service = ShowFavouritesService();

  var favourites = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> loadFavourites() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final token = await AppPreferences.getToken();
      if (token == null || token.isEmpty) {
        errorMessage.value = "No valid token found";
        return;
      }

      final data = await _service.showFavourites(token: token);
      favourites.value = data;
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
