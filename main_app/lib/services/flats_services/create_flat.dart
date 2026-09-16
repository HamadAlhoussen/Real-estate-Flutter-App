import '../../assistant/api.dart';
import '../../models/flat_model.dart';
import '../../assistant/api_config.dart';
import '../../assistant/api_exception.dart';

class CreateFlat {
  Future<FlatModel> create({
    required String governorate,
    required String city,
    required String address,
    required double price,
    required int rooms,
    required int space,
    required int floor,
    required bool hasElevator,
    required bool isFurnished,
    required DateTime availableDate,
    required String section,
    required String flatImagePath,
    required String token,
  }) async {
    final response = await Api().postMultipart(
      url: "$baseUrl/createFlat",
      token: token,
      fields: {
        "governorate": governorate,
        "city": city,
        "address": address,
        "price": price.toString(),
        "rooms": rooms.toString(),
        "space": space.toString(),
        "floor": floor.toString(),
        "has_elevator": hasElevator ? "1" : "0",
        "is_furnished": isFurnished ? "1" : "0",
        "available_date":
            "${availableDate.year}/${availableDate.month}/${availableDate.day}",
        "section": section,
      },
      files: {"flat_image": flatImagePath},
    );

    if (response is Map<String, dynamic>) {
      if (response["error"] != null) {
        throw ApiException(400, response["error"].toString());
      }
      return FlatModel.fromJson(response);
    }

    throw ApiException(500, "Unexpected response format during flat creation");
  }
}
