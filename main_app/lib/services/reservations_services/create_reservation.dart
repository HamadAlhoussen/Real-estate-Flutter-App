import '../../assistant/api.dart';
import '../../assistant/api_config.dart';
import '../../assistant/api_exception.dart';

class CreateReservationService {
  Future<Map<String, dynamic>> createReservation({
    required String token,
    required String startTime,
    required String endTime,
    required int flatId,
    required double price,
  }) async {
    final response = await Api().postForm(
      url: "$baseUrl/createReservation",
      fields: {
        "start_time": startTime,
        "end_time": endTime,
        "flat_id": flatId.toString(),
        "price": price.toString(),
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
      "Unexpected response format during createReservation",
    );
  }
}
