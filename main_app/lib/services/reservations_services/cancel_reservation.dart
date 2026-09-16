import '../../assistant/api.dart';
import '../../assistant/api_config.dart';
import '../../assistant/api_exception.dart';

class CancelReservationService {
  Future<Map<String, dynamic>> cancelReservation({
    required String token,
    required int id,
  }) async {
    final response = await Api().patch(
      url: "$baseUrl/cancelReservation/$id",
      token: token,
    );

    if (response is Map<String, dynamic>) {
      if (response["error"] != null) {
        throw ApiException(400, response["error"].toString());
      }
      return response;
    }

    throw ApiException(
      500,
      "Unexpected response format during cancelReservation",
    );
  }
}
