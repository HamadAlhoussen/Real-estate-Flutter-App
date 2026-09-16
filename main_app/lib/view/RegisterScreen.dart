import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/GlowingCircle.dart';
import '../widgets/GlassTextField.dart';
import '../widgets/DatePickerField.dart';
import '../widgets/Background.dart';
import '../controllers/accounts_controllers/register_controller.dart';
import 'LoginScreen.dart';
import '../locale/locale_controller.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());
    // final firebase_auth = FirebaseAuth.instance.verifyPhoneNumber();
    MyLocaleController controllerLang = Get.find();
    return Scaffold(
      body: Stack(
        children: [
          Background(),
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
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 10),
                        Column(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 110,
                                  height: 110,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white.withOpacity(0.10),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.3),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 38,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white.withOpacity(0.20),
                                  ),
                                  child: Center(
                                    child: IconButton(
                                      icon: const Icon(Icons.add),
                                      color: Colors.white,
                                      iconSize: 22,
                                      onPressed: () => controller.pickAvatar(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Obx(
                              () => Text(
                                controller.avatarPath.value.isEmpty
                                    ? "10".tr
                                    : "11".tr,
                                //  ${controller.avatarPath.value.split('/').last}  "
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(14, 1, 32, 1),
                          ),
                          onPressed: () => controller.pickIdCard(),
                          child: Text(
                            "12".tr,
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          "13".tr,
                          style: TextStyle(
                            fontSize: 28,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 25),
                        GlassTextField(
                          hint: "1".tr,
                          icon: Icons.person,
                          onChanged: (val) => controller.firstName.value = val,
                        ),
                        const SizedBox(height: 12),
                        GlassTextField(
                          hint: "2".tr,
                          icon: Icons.person_outline,
                          onChanged: (val) => controller.lastName.value = val,
                        ),
                        const SizedBox(height: 12),
                        GlassTextField(
                          hint: "3".tr,
                          icon: Icons.phone,
                          onChanged: (val) => controller.phone.value = val,
                        ),
                        const SizedBox(height: 12),
                        GlassTextField(
                          hint: "4".tr,
                          icon: Icons.lock,
                          obscure: true,
                          showToggle: true,
                          onChanged: (val) => controller.password.value = val,
                        ),
                        const SizedBox(height: 12),
                        GlassTextField(
                          hint: "5".tr,
                          icon: Icons.lock_outline,
                          obscure: true,
                          showToggle: true,
                          onChanged: (val) =>
                              controller.passwordConfirmation.value = val,
                        ),
                        const SizedBox(height: 12),
                        DatePickerField(
                          hintt: "6".tr,
                          onDateSelected: (date) =>
                              controller.setBirthDate(date),
                        ),
                        const SizedBox(height: 25),
                        Obx(
                          () => SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: controller.isLoading.value
                                  ? null
                                  : () => controller.register(
                                      firstName: controller.firstName.value,
                                      lastName: controller.lastName.value,
                                      phone: controller.phone.value,
                                      password: controller.password.value,
                                      passwordConfirmation:
                                          controller.passwordConfirmation.value,
                                      avatarPath: controller.avatarPath.value,
                                      idCardPath: controller.idCardPath.value,
                                    ),
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
                              child: controller.isLoading.value
                                  ? const CircularProgressIndicator(
                                      color: Colors.black87,
                                    )
                                  : Text(
                                      "7".tr,
                                      style: TextStyle(fontSize: 19),
                                    ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                "8".tr,
                                style: TextStyle(
                                  color: Colors.white70,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Flexible(
                              child: TextButton(
                                onPressed: () =>
                                    Get.to(() => const LoginScreen()),
                                child: Text(
                                  "9".tr,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 20,
            right: 30,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: IconButton(
                icon: const Icon(Icons.language),
                color: Colors.white,
                onPressed: () {
                  controllerLang.toggleLang();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
