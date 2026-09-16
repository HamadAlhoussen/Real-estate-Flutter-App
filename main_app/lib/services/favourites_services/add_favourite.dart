import '../../assistant/api.dart';
import '../../assistant/api_config.dart';
import '../../assistant/api_exception.dart';

class AddFavouriteService {
  Future<Map<String, dynamic>> addFavourite({
    required String token,
    required int flatId,
  }) async {
    final response = await Api().post(
      url: "$baseUrl/addFavorite/$flatId",
      token: token,
    );

    if (response is Map<String, dynamic>) {
      if (response["error"] != null) {
        throw ApiException(400, response["error"].toString());
      }
      return response;
    }

    throw ApiException(500, "Unexpected response format during addFavourite");
  }
}
