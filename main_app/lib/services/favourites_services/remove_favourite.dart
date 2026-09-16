import '../../assistant/api.dart';
import '../../assistant/api_config.dart';
import '../../assistant/api_exception.dart';

class RemoveFavouriteService {
  Future<Map<String, dynamic>> removeFavourite({
    required String token,
    required int flatId,
  }) async {
    final response = await Api().delete(
      url: "$baseUrl/removeFavorite/$flatId",
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
      "Unexpected response format during removeFavourite",
    );
  }
}
