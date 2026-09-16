import '../../assistant/api.dart';
import '../../assistant/api_config.dart';
import '../../assistant/api_exception.dart';

class ShowFavouritesService {
  Future<List<Map<String, dynamic>>> showFavourites({
    required String token,
  }) async {
    final response = await Api().get(
      url: "$baseUrl/showFavorite",
      token: token,
    );

    if (response is List) {
      return response.cast<Map<String, dynamic>>();
    }

    if (response is Map<String, dynamic> && response["error"] != null) {
      throw ApiException(400, response["error"].toString());
    }

    throw ApiException(500, "Unexpected response format during showFavourites");
  }
}
