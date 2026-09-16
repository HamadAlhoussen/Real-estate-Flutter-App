import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import '../widgets/Background.dart';
import '../widgets/GlassTextField.dart';
import '../widgets/GlowingCircle.dart';
import 'dart:ui';

class Newpassword extends StatelessWidget {
  const Newpassword({super.key});

  @override
  Widget build(BuildContext context) {
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
                        "105".tr,
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 25),
                      GlassTextField(
                        hint: "106".tr,
                        icon: Icons.phone,
                        onChanged: (val) {},
                      ),
                      const SizedBox(height: 15),
                      GlassTextField(
                        hint: "107".tr,
                        icon: Icons.phone,
                        onChanged: (val) {},
                      ),
                      const SizedBox(height: 25),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.85),
                            foregroundColor: Colors.black87,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          child: Text("48".tr, style: TextStyle(fontSize: 19)),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              "108".tr,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 15,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Flexible(
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                "30".tr,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
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
        ],
      ),
    );
  }
}
