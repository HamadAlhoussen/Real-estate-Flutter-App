import 'package:get/get.dart';
import '../../assistant/api_exception.dart';
import '../../services/accounts_services/verify_otp.dart';
import '../../controllers/accounts_controllers/forgot_password_controller.dart';
import '../../view/ResetPasswordScreen.dart';

class ResetFlowOtpController extends GetxController {
  final String phone; // ⭐ phone stored safely here

  ResetFlowOtpController(this.phone);

  final isLoading = false.obs;
  final errorMessage = ''.obs;

  String otp_code = "";

  void updateOtp(String newValue) {
    otp_code = newValue;
    update();
  }

  final secondsLeft = 30.obs;
  final canResend = false.obs;

  final _service = VerifyOtpService();

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    canResend.value = false;
    secondsLeft.value = 30;

    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      secondsLeft.value--;

      if (secondsLeft.value <= 0) {
        canResend.value = true;
        return false;
      }
      return true;
    });
  }

  Future<void> resendOtp() async {
    if (!canResend.value) return;

    try {
      isLoading.value = true;
      errorMessage.value = "";

      final forgotController = Get.find<ForgotPasswordController>();
      await forgotController.sendOtp(phone);

      if (forgotController.errorMessage.isNotEmpty) {
        errorMessage.value = forgotController.errorMessage.value;
        Get.snackbar("Error", forgotController.errorMessage.value);
        return;
      }

      startTimer();
    } catch (e) {
      errorMessage.value = "Unexpected error occurred";
      Get.snackbar("Error", "Unexpected error occurred");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyOtp() async {
    if (otp_code.length != 5) {
      Get.snackbar("OTP Error", "Please enter the 5‑digit code");
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    try {
      await _service.verifyOtp(phone: phone, otpCode: otp_code);

      Get.to(
        () => ResetPasswordScreen(),
        arguments: {"phone": phone, "otp_code": otp_code},
      );
    } on ApiException catch (e) {
      errorMessage.value = e.message;
      Get.snackbar("OTP Failed", e.message);
    } catch (e) {
      errorMessage.value = "Unexpected error occurred";
      Get.snackbar("OTP Failed", "Unexpected error occurred");
    } finally {
      isLoading.value = false;
    }
  }
}
