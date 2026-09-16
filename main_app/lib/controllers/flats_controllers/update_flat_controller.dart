import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import '../../models/flat_model.dart';
import '../../services/flats_services/update_flat.dart';
import '../../controllers/accounts_controllers/refresh_controller.dart';
import '../../assistant/api_exception.dart';

class UpdateFlatController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var updatedFlat = Rxn<FlatModel>();
  var pickedImagePath = ''.obs;
  var selectedSection = RxnString();

  Future<void> pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg'],
    );
    if (result != null && result.files.isNotEmpty) {
      final file = result.files.single;
      if (file.size > 10 * 1024 * 1024) {
        Get.snackbar("Error", "Flat image must be less than 10 MB");
        return;
      }
      pickedImagePath.value = file.path ?? '';
    }
  }

  Future<void> updateFlat({
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
  }) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final token = Get.find<RefreshController>().token.value;
      final service = UpdateFlat();
      final response = await service.update(
        id: id,
        governorate: governorate,
        city: city,
        address: address,
        price: price,
        rooms: rooms,
        space: space,
        floor: floor,
        hasElevator: hasElevator,
        isFurnished: isFurnished,
        status: status,
        section: section ?? selectedSection.value,
        availableDate: availableDate,
        flatImagePath: flatImagePath ?? pickedImagePath.value,
        token: token,
      );
      updatedFlat.value = response;
      Get.snackbar("Success", "Flat updated successfully");
    } on ApiException catch (e) {
      errorMessage.value = e.message;
      Get.snackbar("Error", e.message);
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar("Error", "Unexpected error occurred");
    } finally {
      isLoading.value = false;
    }
  }
}
