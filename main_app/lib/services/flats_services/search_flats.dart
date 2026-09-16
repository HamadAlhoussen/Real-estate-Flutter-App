import '../../assistant/api.dart';
import '../../models/flat_model.dart';
import '../../assistant/api_config.dart';
import '../../assistant/api_exception.dart';

class SearchFlats {
  Future<List<FlatModel>> search({
    required String token,
    String? governorate,
    String? city,
    double? price,
    int? rooms,
    int? space,
    int? floor,
    bool? hasElevator,
    bool? isFurnished,
    bool? noFilter,
  }) async {
    final body = {
      if (governorate != null && governorate.isNotEmpty)
        "governorate": governorate,
      if (city != null && city.isNotEmpty) "city": city,
      if (price != null) "price": price,
      if (rooms != null) "rooms": rooms,
      if (space != null) "space": space,
      if (floor != null) "floor": floor,
      if (hasElevator != null) "has_elevator": hasElevator ? 1 : 0,
      if (isFurnished != null) "is_furnished": isFurnished ? 1 : 0,
      if (noFilter != null) "no_filter": noFilter ? 1 : 0,
    };

    final response = await Api().post(
      url: "$baseUrl/searchFlats",
      token: token,
      body: body,
    );

    if (response is Map<String, dynamic>) {
      if (response["error"] != null) {
        throw ApiException(400, response["error"].toString());
      }
      if (response["data"] is List) {
        return (response["data"] as List)
            .map((e) => FlatModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      if (response["flats"] is List) {
        return (response["flats"] as List)
            .map((e) => FlatModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    }

    if (response is List) {
      return response
          .map((e) => FlatModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    throw ApiException(500, "Unexpected response format during flat search");
  }
}
