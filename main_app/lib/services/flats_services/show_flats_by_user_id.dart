import '../../assistant/api.dart';
import '../../models/flat_model.dart';
import '../../assistant/api_config.dart';
import '../../assistant/api_exception.dart';

class ShowFlatsByUserId {
  Future<List<FlatModel>> getFlats({required String token}) async {
    final response = await Api().get(
      url: "$baseUrl/showFlatsByUserId",
      token: token,
    );

    if (response is Map<String, dynamic> && response["error"] != null) {
      throw ApiException(400, response["error"].toString());
    }

    if (response is List) {
      return response.map((e) => FlatModel.fromJson(e)).toList();
    }

    throw ApiException(
      500,
      "Unexpected response format while fetching flats by user ID",
    );
  }
}
