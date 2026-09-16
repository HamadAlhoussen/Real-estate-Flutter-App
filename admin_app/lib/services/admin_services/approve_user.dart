import '../../assistant/api.dart';
import '../../assistant/api_config.dart';
import '../../assistant/api_exception.dart';

class ApproveUserService {
  Future<void> approveUser(int userId) async {
    final response = await Api().patch(url: "$baseUrl/approve/$userId");

    if (response is Map<String, dynamic> && response['error'] != null) {
      throw ApiException(400, response['error'].toString());
    }
  }
}
