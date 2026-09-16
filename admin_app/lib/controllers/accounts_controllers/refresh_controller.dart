import 'dart:async';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../services/accounts_services/refresh.dart';
import '../../models/token_response_model.dart';
import '../../utils/app_preferances.dart';
import '../../assistant/api_exception.dart';

class RefreshController extends GetxController {
  var token = ''.obs;
  var errorMessage = ''.obs;
  Timer? refreshTimer;

  /// Start auto-refresh after login
  Future<void> startAutoRefresh(String initialToken, int expiresIn) async {
    token.value = initialToken;
    final expiry = DateTime.now().add(Duration(seconds: expiresIn));
    await AppPreferences.saveToken(initialToken, expiry);
    scheduleRefresh(expiresIn);
  }

  /// Schedule the next refresh
  void scheduleRefresh(int expiresInSeconds) {
    refreshTimer?.cancel();

    // Refresh 1 day (86400s) before token expiry if token life is very long
    final refreshBefore = expiresInSeconds > 86400 ? 86400 : 30;

    final refreshIn = expiresInSeconds > refreshBefore
        ? expiresInSeconds - refreshBefore
        : expiresInSeconds;

    refreshTimer = Timer(Duration(seconds: refreshIn), () async {
      await refreshToken(token.value);
    });
  }

  /// Refresh token safely
  Future<String?> refreshToken(String oldToken) async {
    try {
      if (oldToken.isEmpty || JwtDecoder.isExpired(oldToken)) {
        return null; // just return, navigation handled in main
      }

      final TokenResponseModel response = await Refresh().refreshToken(
        token: oldToken,
      );

      token.value = response.token;
      final expiry = DateTime.now().add(Duration(seconds: response.expiresIn));
      await AppPreferences.saveToken(response.token, expiry);

      scheduleRefresh(response.expiresIn);
      return response.token;
    } on ApiException catch (e) {
      errorMessage.value = e.message;
      token.value = '';
      await AppPreferences.clearToken();
      return null;
    } catch (_) {
      errorMessage.value = "Unexpected error occurred";
      token.value = '';
      await AppPreferences.clearToken();
      return null;
    }
  }

  /// Check if stored token is valid
  Future<bool> checkTokenValidity() async {
    final storedToken = await AppPreferences.getToken();
    final expiry = await AppPreferences.getTokenExpiry();

    if (storedToken == null ||
        storedToken.isEmpty ||
        expiry == null ||
        DateTime.now().isAfter(expiry)) {
      token.value = '';
      await AppPreferences.clearToken();
      return false; // no navigation here
    }

    token.value = storedToken;
    return true;
  }

  void stopAutoRefresh() {
    refreshTimer?.cancel();
    refreshTimer = null;
  }

  @override
  void onClose() {
    stopAutoRefresh();
    super.onClose();
  }
}
