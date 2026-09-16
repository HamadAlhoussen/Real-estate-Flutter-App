import 'package:get/get.dart';
import '../../models/flat_model.dart';
import '../../services/flats_services/search_flats.dart';
import '../../controllers/accounts_controllers/refresh_controller.dart';
import '../../assistant/api_exception.dart';

class SearchFlatsController extends GetxController {
  final flats = <FlatModel>[].obs;

  final luxuryFlats = <FlatModel>[].obs;
  final standardFlats = <FlatModel>[].obs;
  final bedFlats = <FlatModel>[].obs;
  final otherFlats = <FlatModel>[].obs;

  final isLoading = false.obs;
  final errorMessage = ''.obs;

  final _service = SearchFlats();

  Future<void> searchFlats({
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
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final token = Get.find<RefreshController>().token.value;

      final results = await _service.search(
        token: token,
        governorate: governorate,
        city: city,
        price: price,
        rooms: rooms,
        space: space,
        floor: floor,
        hasElevator: hasElevator,
        isFurnished: isFurnished,
        noFilter: noFilter,
      );

      flats.assignAll(results);
      _categorizeBySection(results);

      if (results.isEmpty) {
        Get.snackbar('Notice', 'No flats found for the given criteria');
      }
    } on ApiException catch (e) {
      errorMessage.value = e.message;
      Get.snackbar('Error', "Flat not Found");
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar('Error', 'Unexpected error occurred');
    } finally {
      isLoading.value = false;
    }
  }

  void _categorizeBySection(List<FlatModel> allFlats) {
    luxuryFlats.clear();
    standardFlats.clear();
    bedFlats.clear();
    otherFlats.clear();

    for (final flat in allFlats) {
      switch (flat.section) {
        case 'Luxury Apartments':
        case 'luxury apartments':
        case 'شقق فاخرة':
          luxuryFlats.add(flat);
          break;
        case 'Standard Apartments':
        case 'standard apartments':
        case 'شقق عادية':
          standardFlats.add(flat);
          break;
        case 'Bed Spaces':
        case 'bed spaces':
        case 'أماكن نوم':
          bedFlats.add(flat);
          break;
        default:
          otherFlats.add(flat);
      }
    }
  }
}
