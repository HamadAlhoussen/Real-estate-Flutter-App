import 'package:get/get.dart';
import '../../services/reservations_services/show_reservations.dart';
import '../../assistant/api_exception.dart';
import '../../utils/app_preferances.dart'; // <-- for token

class ShowReservationController extends GetxController {
  final _service = ShowReservationService();

  var reservations = <Map<String, dynamic>>[].obs;

  var currentReservations = <Map<String, dynamic>>[].obs;
  var pastReservations = <Map<String, dynamic>>[].obs;

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> loadReservations() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final token = await AppPreferences.getToken();
      if (token == null || token.isEmpty) {
        errorMessage.value = "No valid token found";
        return;
      }

      final data = await _service.showReservations(token: token);
      reservations.value = data;

      final now = DateTime.now();
      currentReservations.value = data.where((r) {
        final end = DateTime.tryParse(r["end_time"] ?? '');
        return end != null && end.isAfter(now);
      }).toList();

      pastReservations.value = data.where((r) {
        final end = DateTime.tryParse(r["end_time"] ?? '');
        return end != null && end.isBefore(now);
      }).toList();
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
