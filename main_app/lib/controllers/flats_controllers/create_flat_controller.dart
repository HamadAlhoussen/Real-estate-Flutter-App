import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import '../../models/flat_model.dart';
import '../../services/flats_services/create_flat.dart';
import '../../controllers/accounts_controllers/refresh_controller.dart';
import '../../assistant/api_exception.dart';

class CreateFlatController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var createdFlat = Rxn<FlatModel>();
  var pickedImagePath = ''.obs;

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

  Future<void> createFlat({
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
    String? flatImagePath,
  }) async {
    final imagePath = flatImagePath ?? pickedImagePath.value;

    if (imagePath.isEmpty) {
      Get.snackbar("Error", "Image is required to create a flat");
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final token = Get.find<RefreshController>().token.value;
      final service = CreateFlat();

      final response = await service.create(
        governorate: governorate,
        city: city,
        address: address,
        price: price,
        rooms: rooms,
        space: space,
        floor: floor,
        hasElevator: hasElevator,
        isFurnished: isFurnished,
        availableDate: availableDate,
        section: section,
        flatImagePath: imagePath,
        token: token,
      );

      createdFlat.value = response;
      Get.snackbar("Success", "Flat created successfully");
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
