import '../../assistant/api.dart';
import '../../models/flat_model.dart';
import '../../assistant/api_config.dart';
import '../../assistant/api_exception.dart';

class ShowFlatById {
  Future<FlatModel> getFlat({required int id, required String token}) async {
    final response = await Api().get(
      url: "$baseUrl/showFlatById/$id",
      token: token,
    );

    if (response is Map<String, dynamic>) {
      if (response["error"] != null) {
        throw ApiException(404, response["error"].toString());
      }
      return FlatModel.fromJson(response);
    }

    throw ApiException(
      500,
      "Unexpected response format while fetching flat by ID",
    );
  }
}
