import 'package:get/get.dart';
import '../../assistant/api_exception.dart';
import '../../services/accounts_services/forgot_password.dart';
import '../../view/PasswordOTPScreen.dart'; // make sure this import exists

class ForgotPasswordController extends GetxController {
  final ForgotPasswordService _service = ForgotPasswordService();

  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var successMessage = ''.obs;

  Future<void> sendOtp(String phone) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      successMessage.value = '';

      final response = await _service.sendOtp(phone: phone);

      successMessage.value = response["message"] ?? "OTP sent";

      Get.to(() => PasswordOtpScreen(), arguments: {"phone": phone});
    } on ApiException catch (e) {
      errorMessage.value = e.message;
    } catch (_) {
      errorMessage.value = "Unexpected error occurred";
    } finally {
      isLoading.value = false;
    }
  }
}
