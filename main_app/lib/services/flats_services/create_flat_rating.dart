import '../../assistant/api.dart';
import '../../assistant/api_config.dart';
import '../../assistant/api_exception.dart';

class CreateFlatRating {
  Future<Map<String, dynamic>> rate({
    required int flatId,
    required int rating,
    required String token,
  }) async {
    final response = await Api().post(
      url: "$baseUrl/flatRating/$flatId",
      token: token,
      body: {"rating": rating.toString()},
    );

    if (response is Map<String, dynamic>) {
      if (response["error"] != null) {
        throw ApiException(400, response["error"].toString());
      }
      return response;
    }

    throw ApiException(500, "Unexpected response format during flat rating");
  }
}
