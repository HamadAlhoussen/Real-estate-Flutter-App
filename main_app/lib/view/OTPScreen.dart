import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/GlowingCircle.dart';
import '../widgets/Background.dart';
import '../../controllers/accounts_controllers/otp_controller.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final otpController = Get.put(OtpController());
    final phone = Get.arguments["phone"];

    final List<TextEditingController> controllers = List.generate(
      5,
      (_) => TextEditingController(),
    );

    final List<FocusNode> focusNodes = List.generate(5, (_) => FocusNode());

    void updateUnifiedOtp() {
      final newOtp = controllers.map((c) => c.text).join();
      otpController.updateOtp(newOtp);
    }

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

                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Verify OTP",
                          style: TextStyle(
                            fontSize: 28,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 15),

                        Text(
                          "Enter the 5‑digit code sent to $phone",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white70,
                          ),
                        ),

                        const SizedBox(height: 25),

                        GetBuilder<OtpController>(
                          builder: (_) {
                            return Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              alignment: WrapAlignment.center,

                              children: List.generate(5, (index) {
                                final isActive = focusNodes[index].hasFocus;

                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 90),
                                  width: 48,
                                  height: 58,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: isActive
                                          ? Colors.white.withOpacity(0.9)
                                          : Colors.white.withOpacity(0.4),
                                      width: isActive ? 2 : 1,
                                    ),
                                    color: Colors.white.withOpacity(0.08),
                                    boxShadow: isActive
                                        ? [
                                            BoxShadow(
                                              color: Colors.white.withOpacity(
                                                0.25,
                                              ),
                                              blurRadius: 8,
                                              spreadRadius: 1,
                                            ),
                                          ]
                                        : [],
                                  ),
                                  child: TextField(
                                    controller: controllers[index],
                                    focusNode: focusNodes[index],
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    maxLength: 1,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    decoration: const InputDecoration(
                                      counterText: "",
                                      border: InputBorder.none,
                                    ),

                                    onChanged: (value) {
                                      if (value.isNotEmpty) {
                                        if (index < 4) {
                                          focusNodes[index + 1].requestFocus();
                                        } else {
                                          focusNodes[index].unfocus();
                                        }
                                      } else {
                                        if (index > 0) {
                                          focusNodes[index - 1].requestFocus();
                                        }
                                      }

                                      updateUnifiedOtp();
                                    },
                                  ),
                                );
                              }),
                            );
                          },
                        ),

                        const SizedBox(height: 25),

                        Obx(() {
                          return SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: otpController.isLoading.value
                                  ? null
                                  : () => otpController.verifyOtp(),
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
                              child: otpController.isLoading.value
                                  ? const CircularProgressIndicator(
                                      color: Colors.black,
                                    )
                                  : const Text(
                                      "Verify",
                                      style: TextStyle(fontSize: 19),
                                    ),
                            ),
                          );
                        }),

                        const SizedBox(height: 15),

                        Obx(() {
                          final canResend = otpController.canResend.value;

                          return Wrap(
                            spacing: 12,
                            runSpacing: 8,
                            alignment: WrapAlignment.spaceBetween,

                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  canResend
                                      ? "You can resend now"
                                      : "Try again in ${otpController.secondsLeft.value}s",
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 15,
                                  ),
                                ),
                              ),

                              ElevatedButton(
                                onPressed: canResend
                                    ? () => otpController.resendOtp()
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white.withOpacity(
                                    canResend ? 0.85 : 0.25,
                                  ),
                                  foregroundColor: Colors.black87,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 10,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  elevation: canResend ? 3 : 0,
                                ),
                                child: const Text(
                                  "Try again",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          );
                        }),

                        const SizedBox(height: 15),

                        Obx(() {
                          return otpController.errorMessage.isNotEmpty
                              ? Text(
                                  otpController.errorMessage.value,
                                  style: const TextStyle(color: Colors.red),
                                )
                              : const SizedBox.shrink();
                        }),
                      ],
                    ),
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
