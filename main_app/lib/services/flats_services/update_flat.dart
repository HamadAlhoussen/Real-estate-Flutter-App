import '../../assistant/api.dart';
import '../../models/flat_model.dart';
import '../../assistant/api_config.dart';
import '../../assistant/api_exception.dart';

class UpdateFlat {
  Future<FlatModel> update({
    required int id,
    String? governorate,
    String? city,
    String? address,
    double? price,
    int? rooms,
    int? space,
    int? floor,
    bool? hasElevator,
    bool? isFurnished,
    String? status,
    String? section,
    DateTime? availableDate,
    String? flatImagePath,
    required String token,
  }) async {
    final Map<String, String> fields = {"_method": "PUT"};

    if (governorate != null) fields["governorate"] = governorate;
    if (city != null) fields["city"] = city;
    if (address != null) fields["address"] = address;
    if (price != null) fields["price"] = price.toString();
    if (rooms != null) fields["rooms"] = rooms.toString();
    if (space != null) fields["space"] = space.toString();
    if (floor != null) fields["floor"] = floor.toString();
    if (hasElevator != null) fields["has_elevator"] = hasElevator ? "1" : "0";
    if (isFurnished != null) fields["is_furnished"] = isFurnished ? "1" : "0";
    if (status != null) fields["status"] = status;
    if (section != null) fields["section"] = section;

    if (availableDate != null) {
      fields["available_date"] =
          "${availableDate.year}/${availableDate.month}/${availableDate.day}";
    }

    final Map<String, String> files = {};
    if (flatImagePath != null && flatImagePath.isNotEmpty) {
      files["flat_image"] = flatImagePath;
    }

    final response = await Api().postMultipart(
      url: "$baseUrl/updateFlat/$id",
      token: token,
      fields: fields,
      files: files,
    );

    if (response is Map<String, dynamic>) {
      if (response["error"] != null) {
        throw ApiException(400, response["error"].toString());
      }
      return FlatModel.fromJson(response);
    }

    throw ApiException(500, "Unexpected response format during flat update");
  }
}
