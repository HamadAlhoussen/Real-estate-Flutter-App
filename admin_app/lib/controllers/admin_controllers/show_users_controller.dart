import 'package:get/get.dart';
import '../../services/admin_services/show_users.dart';
import '../../assistant/api_exception.dart';
import '../../models/managed_account_model.dart';

class ShowUsersController extends GetxController {
  final _service = ShowUsersService();

  final users = <ManagedAccountModel>[].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  Future<void> loadUsers() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final rawUsers = await _service.showUsers();

      users.value = rawUsers
          .map((json) => ManagedAccountModel.fromJson(json))
          .toList();
    } on ApiException catch (e) {
      errorMessage.value = e.message;
    } catch (_) {
      errorMessage.value = "Unexpected error occurred";
    } finally {
      isLoading.value = false;
    }
  }

  List<ManagedAccountModel> get pendingUsers =>
      users.where((u) => u.status == 'pending').toList();

  List<ManagedAccountModel> get approvedUsers =>
      users.where((u) => u.status == 'approved').toList();

  List<ManagedAccountModel> get rejectedUsers =>
      users.where((u) => u.status == 'rejected').toList();
}
