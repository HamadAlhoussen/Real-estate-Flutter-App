import 'package:get/get.dart';
import '../../services/reservations_services/reservation_requests.dart';
import '../../assistant/api_exception.dart';
import '../../models/reservation_model.dart';
import '../../utils/app_preferances.dart';

class BookingRequestsController extends GetxController {
  final _service = BookingRequestsService();

  final requests = <ReservationModel>[].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  Future<void> loadRequests() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final token = await AppPreferences.getToken();
      if (token == null || token.isEmpty) {
        errorMessage.value = "No valid token found";
        return;
      }

      final rawRequests = await _service.showRequests(token: token);
      requests.value = rawRequests
          .map((json) => ReservationModel.fromJson(json))
          .toList();
    } on ApiException catch (e) {
      errorMessage.value = e.message;
    } catch (_) {
      errorMessage.value = "Unexpected error occurred";
    } finally {
      isLoading.value = false;
    }
  }
}
