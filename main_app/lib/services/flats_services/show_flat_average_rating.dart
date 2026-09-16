import '../../assistant/api.dart';
import '../../assistant/api_config.dart';
import '../../assistant/api_exception.dart';

class ShowFlatAverageRating {
  Future<double> fetch({required int flatId, required String token}) async {
    final response = await Api().get(
      url: "$baseUrl/showAvgRating/$flatId",
      token: token,
    );

    if (response is Map<String, dynamic>) {
      if (response["error"] != null) {
        throw ApiException(400, response["error"].toString());
      }
      return double.tryParse(response["average_rating"].toString()) ?? 0.0;
    }

    throw ApiException(
      500,
      "Unexpected response format while fetching average rating",
    );
  }
}
