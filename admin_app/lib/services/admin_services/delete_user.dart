import '../../assistant/api.dart';
import '../../assistant/api_config.dart';
import '../../assistant/api_exception.dart';

class DeleteUserService {
  Future<void> deleteUser(int userId) async {
    final response = await Api().delete(url: "$baseUrl/delete/$userId");

    if (response is Map<String, dynamic> && response['error'] != null) {
      throw ApiException(400, response['error'].toString());
    }
  }
}
