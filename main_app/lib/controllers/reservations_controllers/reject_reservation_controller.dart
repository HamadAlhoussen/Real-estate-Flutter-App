import 'package:get/get.dart';
import '../../services/reservations_services/reject_reservation.dart';
import '../../utils/app_preferances.dart';

class RejectReservationController extends GetxController {
  final _service = RejectReservationService();

  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var result = <String, dynamic>{}.obs;

  Future<void> rejectReservation(int id) async {
    try {
      isLoading.value = true;
      final token = await AppPreferences.getToken();
      if (token == null || token.isEmpty) {
        errorMessage.value = "No valid token found";
        return;
      }

      final response = await _service.rejectReservation(token: token, id: id);
      result.value = response;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
