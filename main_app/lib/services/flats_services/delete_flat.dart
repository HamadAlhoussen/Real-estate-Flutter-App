import '../../assistant/api.dart';
import '../../assistant/api_config.dart';
import '../../assistant/api_exception.dart';

class DeleteFlat {
  Future<Map<String, dynamic>> delete({
    required int id,
    required String token,
  }) async {
    final response = await Api().delete(
      url: "$baseUrl/deleteFlat/$id",
      token: token,
    );

    if (response is Map<String, dynamic>) {
      if (response["error"] != null) {
        throw ApiException(400, response["error"].toString());
      }
      return response;
    }

    throw ApiException(500, "Unexpected response format during flat deletion");
  }
}
