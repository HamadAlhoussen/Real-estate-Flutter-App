import '../../assistant/api.dart';
import '../../assistant/api_config.dart';
import '../../assistant/api_exception.dart';

class ShowUsersService {
  Future<List<Map<String, dynamic>>> showUsers() async {
    final response = await Api().get(url: "$baseUrl/showUsers");

    if (response is List) {
      return List<Map<String, dynamic>>.from(response);
    }

    throw ApiException(500, "Unexpected response format while fetching users");
  }
}
