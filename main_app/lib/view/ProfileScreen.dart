import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../utils/app_preferances.dart';
import '../controllers/accounts_controllers/me_controller.dart';
import '../controllers/accounts_controllers/logout_controller.dart';
import '../controllers/accounts_controllers/refresh_controller.dart';
import 'LoginScreen.dart';
import '../widgets/ContainerForProfile.dart';
import '../widgets/Background.dart';
import '../widgets/GlowingCircle.dart';
import 'UpdateUserInfo.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final meController = Get.put(MeController());
  final logoutController = Get.put(LogoutController());

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    String token = Get.find<RefreshController>().token.value;
    if (token.isEmpty) {
      final storedToken = await AppPreferences.getToken();
      if (storedToken != null && storedToken.isNotEmpty) {
        token = storedToken;
        Get.find<RefreshController>().token.value = token;
      }
    }
    if (token.isNotEmpty) {
      await meController.getUser();
    } else {
      meController.errorMessage.value = "No token found. Please log in again.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (meController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (meController.errorMessage.value.isNotEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Get.snackbar(
              "Error",
              meController.errorMessage.value,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red.withOpacity(0.7),
              colorText: Colors.white,
            );
            meController.errorMessage.value = '';
          });
        }

        final user = meController.user.value;
        if (user == null) {
          return Center(child: Text("89".tr));
        }

        return Stack(
          children: [
            const Background(),
            Positioned(
              top: -100,
              left: -80,
              child: GlowingCircle(
                diameter: 300,
                color: const Color(0xFF6A4CFF).withOpacity(0.45),
              ),
            ),
            Positioned(
              bottom: -120,
              right: -100,
              child: GlowingCircle(
                diameter: 350,
                color: const Color(0xFF00D1FF).withOpacity(0.40),
              ),
            ),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    width: 330,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 65,
                            backgroundColor: Colors.grey.shade300,
                            backgroundImage: user.avatarPath.isNotEmpty
                                ? NetworkImage(user.avatarPath)
                                : null,
                            child: user.avatarPath.isEmpty
                                ? const Icon(Icons.person, size: 70)
                                : null,
                          ),
                          const SizedBox(height: 30),

                          Containerforprofile(L: "1".tr, V: user.firstName),
                          const SizedBox(height: 15),

                          Containerforprofile(L: "2".tr, V: user.lastName),
                          const SizedBox(height: 15),

                          Containerforprofile(L: "3".tr, V: user.phone),
                          const SizedBox(height: 15),

                          Container(
                            height: 130,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: user.idCardPath.isNotEmpty
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      user.idCardPath,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : const Center(
                                    child: Text(
                                      "ID Card Image Placeholder",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                          ),
                          const SizedBox(height: 15),

                          Containerforprofile(
                            L: "6".tr,
                            V: DateFormat('dd/MM/yyyy').format(user.birthDate),
                          ),
                          const SizedBox(height: 30),

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => UpdateUserInfo(user: user),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white.withOpacity(0.85),
                                foregroundColor: Colors.black87,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              child: Text(
                                "49".tr,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: logoutController.isLoading.value
                                  ? null
                                  : () async {
                                      await logoutController.logout();
                                      Get.offAll(() => const LoginScreen());
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white.withOpacity(0.85),
                                foregroundColor: Colors.black87,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              child: logoutController.isLoading.value
                                  ? const CircularProgressIndicator(
                                      color: Colors.black,
                                    )
                                  : Text(
                                      "32".tr,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
