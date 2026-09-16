import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/GlassTextField.dart';
import '../widgets/DatePickerField.dart';
import '../widgets/GlowingCircle.dart';
import '../widgets/Background.dart';
import '../../controllers/accounts_controllers/update_user_controller.dart';
import '../../controllers/accounts_controllers/refresh_controller.dart';
import '../../models/user_account_model.dart';

class UpdateUserInfo extends StatefulWidget {
  final UserAccountModel user;
  const UpdateUserInfo({super.key, required this.user});

  @override
  State<UpdateUserInfo> createState() => _UpdateUserInfoState();
}

class _UpdateUserInfoState extends State<UpdateUserInfo> {
  late String? firstName;
  late String? lastName;
  late DateTime? birthDate;

  final updateController = Get.put(UpdateUserController());

  @override
  void initState() {
    super.initState();
    firstName = widget.user.firstName;
    lastName = widget.user.lastName;
    birthDate = widget.user.birthDate;
    updateController.updatedAvatarPath.value = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Background(),
          Positioned(
            top: -100,
            left: -80,
            child: GlowingCircle(
              diameter: 300,
              color: const Color(0xFF6A4CFF).withOpacity(0.7),
            ),
          ),
          Positioned(
            bottom: -120,
            right: -100,
            child: GlowingCircle(
              diameter: 350,
              color: const Color(0xFF00D1FF).withOpacity(0.65),
            ),
          ),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Container(
                width: 330,
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (Get.locale?.languageCode == 'en') ...[
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ] else ...[
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ],
                      const SizedBox(height: 10),
                      CircleAvatar(
                        radius: 65,
                        backgroundColor: Colors.grey.shade300,
                        backgroundImage: widget.user.avatarPath.isNotEmpty
                            ? NetworkImage(widget.user.avatarPath)
                            : null,
                        child: widget.user.avatarPath.isEmpty
                            ? const Icon(Icons.person, size: 70)
                            : null,
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: updateController.updateAvatar,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.85),
                            foregroundColor: Colors.black87,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          child: Text(
                            "47".tr,
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      GlassTextField(
                        hint: "1".tr,
                        icon: Icons.person,
                        initialValue: firstName,
                        onChanged: (v) => firstName = v,
                      ),
                      const SizedBox(height: 15),
                      GlassTextField(
                        hint: "2".tr,
                        icon: Icons.person,
                        initialValue: lastName,
                        onChanged: (v) => lastName = v,
                      ),
                      const SizedBox(height: 15),

                      DatePickerField(
                        hintt: "6".tr,
                        initialDate: birthDate,
                        onDateSelected: (date) {
                          setState(() => birthDate = date);
                        },
                      ),

                      const SizedBox(height: 25),
                      Obx(() {
                        return Column(
                          children: [
                            ElevatedButton(
                              onPressed: updateController.isLoading.value
                                  ? null
                                  : () async {
                                      final confirm = await showDialog<bool>(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                          title: Text("77".tr),
                                          content: Text("78".tr),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(ctx).pop(false),
                                              child: Text("30".tr),
                                            ),
                                            ElevatedButton(
                                              onPressed: () =>
                                                  Navigator.of(ctx).pop(true),
                                              child: Text("48".tr),
                                            ),
                                          ],
                                        ),
                                      );

                                      if (confirm == true) {
                                        final token =
                                            Get.find<RefreshController>()
                                                .token
                                                .value;
                                        await updateController.updateUser(
                                          token: token,
                                          firstName: firstName,
                                          lastName: lastName,
                                          avatarPath:
                                              updateController
                                                  .updatedAvatarPath
                                                  .value
                                                  .isNotEmpty
                                              ? updateController
                                                    .updatedAvatarPath
                                                    .value
                                              : null,
                                          birthDate: birthDate,
                                        );

                                        Navigator.pop(context);
                                      }
                                    },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              child: updateController.isLoading.value
                                  ? const CircularProgressIndicator()
                                  : Text(
                                      "48".tr,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                            if (updateController.errorMessage.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  updateController.errorMessage.value,
                                  style: const TextStyle(
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ),
                          ],
                        );
                      }),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
