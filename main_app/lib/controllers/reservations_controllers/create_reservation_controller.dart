import 'package:get/get.dart';
import '../../services/reservations_services/create_reservation.dart';
import '../../assistant/api_exception.dart';

class CreateReservationController extends GetxController {
  final _service = CreateReservationService();

  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var result = <String, dynamic>{}.obs;

  Future<void> createReservation(
    String token,
    String startTime,
    String endTime,
    int flatId,
    double price,
  ) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _service.createReservation(
        token: token,
        startTime: startTime,
        endTime: endTime,
        flatId: flatId,
        price: price,
      );

      if (response['message'] == "You cannt reserve your own flat") {
        Get.snackbar("Reservation Error", response['message']);
        return;
      }

      result.value = response;
      Get.snackbar("Success", "Reservation created successfully");
    } on ApiException catch (e) {
      errorMessage.value = e.message;
      Get.snackbar("Reservation Failed", e.message);
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar("Reservation Failed", "Unexpected error occurred");
    } finally {
      isLoading.value = false;
    }
  }
}
