import '../../assistant/api.dart';
import '../../assistant/api_config.dart';
import '../../assistant/api_exception.dart';

class BookingRequestsService {
  Future<List<Map<String, dynamic>>> showRequests({
    required String token,
  }) async {
    final response = await Api().get(
      url: "$baseUrl/ShowAllReservationsForUserFlats",
      token: token,
    );

    if (response is List) {
      return List<Map<String, dynamic>>.from(response);
    }

    throw ApiException(
      500,
      "Unexpected response format while fetching booking requests",
    );
  }
}
