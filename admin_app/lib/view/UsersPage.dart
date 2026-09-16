import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/admin_controllers/show_users_controller.dart';
import '../../controllers/admin_controllers/approve_user_controller.dart';
import '../../controllers/admin_controllers/reject_user_controller.dart';
import '../../controllers/admin_controllers/delete_user_controller.dart';
import '../../models/managed_account_model.dart';

class UsersPage extends StatefulWidget {
  final int statusIndex;
  const UsersPage({super.key, required this.statusIndex});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final controller = Get.put(ShowUsersController());
  final approveController = Get.put(ApproveUserController());
  final rejectController = Get.put(RejectUserController());
  final deleteController = Get.put(DeleteUserController());

  @override
  void initState() {
    super.initState();
    controller.loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (controller.errorMessage.isNotEmpty) {
        return Center(child: Text("Error: ${controller.errorMessage}"));
      }

      List<ManagedAccountModel> users;
      switch (widget.statusIndex) {
        case 0:
          users = controller.pendingUsers;
          break;
        case 1:
          users = controller.approvedUsers;
          break;
        case 2:
          users = controller.rejectedUsers;
          break;
        default:
          users = [];
      }

      return _buildUserList(users);
    });
  }

  Widget _buildUserList(List<ManagedAccountModel> users) {
    if (users.isEmpty) {
      return Center(child: Text("46".tr));
    }
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: ExpansionTile(
            leading: CircleAvatar(
              backgroundImage: user.avatarPath.isNotEmpty
                  ? NetworkImage(user.avatarPath)
                  : null,
              child: user.avatarPath.isEmpty
                  ? const Icon(Icons.person_outline)
                  : null,
            ),
            title: Text("${user.firstName} ${user.lastName}"),
            subtitle: Text("${user.birthDate.toLocal()}".split(' ')[0]),
            children: [
              ListTile(title: const Text("Phone"), subtitle: Text(user.phone)),
              ListTile(
                title: const Text("ID Card"),
                // ignore: unnecessary_null_comparison
                subtitle: user.idCardPath != null && user.idCardPath.isNotEmpty
                    ? Image.network(
                        user.idCardPath,
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Text("Failed to load ID card");
                        },
                      )
                    : const Text("No ID card available"),
              ),

              ListTile(
                title: const Text("Status"),
                subtitle: Text(user.status),
              ),
              _buildActionButtons(user),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActionButtons(ManagedAccountModel user) {
    if (user.status == 'pending') {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () async {
                await approveController.approveUser(user.id);
                _updateUserStatus(user.id, 'approved');
              },
              child: const Text(
                "Approve",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () async {
                await rejectController.rejectUser(user.id);
                _updateUserStatus(user.id, 'rejected');
              },
              child: const Text(
                "Reject",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(6, 10, 53, 1),
              ),
              onPressed: () async {
                if (user.status == 'approved') {
                  await rejectController.rejectUser(user.id);
                  _updateUserStatus(user.id, 'rejected');
                } else if (user.status == 'rejected') {
                  await approveController.approveUser(user.id);
                  _updateUserStatus(user.id, 'approved');
                }
              },
              child: const Text(
                "Edit Status",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Padding(
            padding: const EdgeInsets.all(15),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Confirm Delete"),
                    content: const Text(
                      "Are you sure you want to delete this user?",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text("Delete"),
                      ),
                    ],
                  ),
                );

                if (confirm == true) {
                  await deleteController.deleteUser(user.id);
                  setState(() {
                    controller.users.removeWhere((u) => u.id == user.id);
                  });
                }
              },
              child: const Text(
                "Delete",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      );
    }
  }

  void _updateUserStatus(int userId, String newStatus) {
    final idx = controller.users.indexWhere((u) => u.id == userId);
    if (idx != -1) {
      controller.users[idx] = controller.users[idx].copyWith(status: newStatus);
    }
  }
}
