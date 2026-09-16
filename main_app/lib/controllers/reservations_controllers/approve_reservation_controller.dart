import 'package:get/get.dart';
import '../../services/reservations_services/approve_reservation.dart';
import '../../utils/app_preferances.dart';

class ApproveReservationController extends GetxController {
  final _service = ApproveReservationService();

  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var result = <String, dynamic>{}.obs;

  Future<void> approveReservation(int id) async {
    try {
      isLoading.value = true;
      final token = await AppPreferences.getToken();
      if (token == null || token.isEmpty) {
        errorMessage.value = "No valid token found";
        return;
      }

      final response = await _service.approveReservation(token: token, id: id);
      result.value = response;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
