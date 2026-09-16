import '../../assistant/api.dart';
import '../../assistant/api_config.dart';
import '../../assistant/api_exception.dart';

class UpdateReservationService {
  Future<Map<String, dynamic>> updateReservation({
    required String token,
    required int id,
    required String startTime,
    required String endTime,
  }) async {
    final response = await Api().put(
      url: "$baseUrl/updateReservation",
      fields: {
        "id": id.toString(),
        "start_time": startTime,
        "end_time": endTime,
      },
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
      "Unexpected response format during updateReservation",
    );
  }
}
