import 'package:get/get.dart';
import '../../services/accounts_services/otp.dart';
import '../../models/token_response_model.dart';
import '../../controllers/accounts_controllers/refresh_controller.dart';
import '../../controllers/accounts_controllers/me_controller.dart';
import '../../assistant/api_exception.dart';
import '../../utils/app_preferances.dart';
import '../../view/MyAp.dart';
import '../../controllers/accounts_controllers/login_controller.dart';

class OtpController extends GetxController {
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  String otp_code = "";

  void updateOtp(String newValue) {
    otp_code = newValue;
    update();
  }

  final secondsLeft = 30.obs;
  final canResend = false.obs;

  final _service = OtpService();

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

    final loginController = Get.find<LoginController>();
    loginController.login();

    startTimer();
  }

  Future<void> verifyOtp() async {
    final phone = Get.arguments["phone"];

    if (otp_code.length != 5) {
      Get.snackbar("OTP Error", "Please enter the 5‑digit code");
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final TokenResponseModel response = await _service.verifyOtp(
        phone: phone,
        otp_code: otp_code,
      );

      final expiryDate = DateTime.now().add(
        Duration(seconds: response.expiresIn),
      );

      await AppPreferences.saveToken(response.token, expiryDate);

      final refreshController = Get.find<RefreshController>();
      await refreshController.startAutoRefresh(
        response.token,
        response.expiresIn,
      );

      final meController = Get.find<MeController>();
      meController.errorMessage.value = '';
      await meController.getUser();

      Get.offAll(() => const MyAp());
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
