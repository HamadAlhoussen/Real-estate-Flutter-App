import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'RegisterScreen.dart';
import '../widgets/GlassTextField.dart';
import '../widgets/GlowingCircle.dart';
import '../widgets/Background.dart';
import '../controllers/accounts_controllers/login_controller.dart';
import '../locale/locale_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LoginController());
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
              color: const Color(0xFF6A4CFF).withOpacity(0.70),
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "14".tr,
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 25),
                      GlassTextField(
                        hint: "3".tr,
                        icon: Icons.phone,
                        onChanged: (val) => loginController.phone.value = val,
                      ),
                      const SizedBox(height: 15),
                      GlassTextField(
                        hint: "4".tr,
                        icon: Icons.lock,
                        obscure: true,
                        showToggle: true,
                        onChanged: (val) =>
                            loginController.password.value = val,
                      ),
                      const SizedBox(height: 25),
                      Obx(
                        () => SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: loginController.isLoading.value
                                ? null
                                : () => loginController.login(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white.withOpacity(0.85),
                              foregroundColor: Colors.black87,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                            child: loginController.isLoading.value
                                ? const CircularProgressIndicator(
                                    color: Colors.black,
                                  )
                                : Text("14".tr, style: TextStyle(fontSize: 19)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              "15".tr,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 15,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          // Flexible(
                          //   child: TextButton(
                          //     onPressed: () =>
                          //         Get.to(() => const RegisterScreen()),
                          //     child:  Text(
                          //       "16".tr,
                          //       style: TextStyle(
                          //         color: Colors.white,
                          //         fontWeight: FontWeight.bold,
                          //         fontSize: 20
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ],
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
