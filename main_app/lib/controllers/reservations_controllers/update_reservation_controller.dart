import 'package:get/get.dart';
import '../../services/reservations_services/update_reservation.dart';
import '../../assistant/api_exception.dart';
import '../../utils/app_preferances.dart';

class UpdateReservationController extends GetxController {
  final _service = UpdateReservationService();

  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var result = <String, dynamic>{}.obs;

  Future<void> updateReservation(
    int id,
    String startTime,
    String endTime,
  ) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

  
      final token = await AppPreferences.getToken();
      if (token == null || token.isEmpty) {
        errorMessage.value = "No valid token found";
        return;
      }

      final response = await _service.updateReservation(
        token: token,
        id: id,
        startTime: startTime,
        endTime: endTime,
      );

      result.value = response;
      Get.snackbar("Success", "Reservation updated");
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
