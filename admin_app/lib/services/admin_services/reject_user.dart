import '../../assistant/api.dart';
import '../../assistant/api_config.dart';
import '../../assistant/api_exception.dart';

class RejectUserService {
  Future<void> rejectUser(int userId) async {
    final response = await Api().patch(url: "$baseUrl/reject/$userId");

    if (response is Map<String, dynamic> && response['error'] != null) {
      throw ApiException(400, response['error'].toString());
    }
  }
}
