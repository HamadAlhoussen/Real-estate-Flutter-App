import 'package:flutter/material.dart';
import 'onboarding_pages.dart';
import '../widgets/onboarding_page.dart';
import '../widgets/dots_indicator.dart';
import '../widgets/next_button.dart';
import 'RegisterScreen.dart';
import 'package:get/get.dart';
import '../locale/locale_controller.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < onboardingPages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const RegisterScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final page = onboardingPages[_currentPage];
    final MyLocaleController controllerLang = Get.find();

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: onboardingPages.length,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemBuilder: (_, index) =>
                OnboardingPage(data: onboardingPages[index]),
          ),
          _buildGradient(),
          _buildBottomContent(page, controllerLang),
        ],
      ),
    );
  }

  Widget _buildGradient() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0.1),
            Colors.black.withOpacity(0.8),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomContent(page, MyLocaleController controllerLang) {
    return Stack(
      children: [
        if (Get.locale?.languageCode == 'en') ...[
          Positioned(
            top: 20,
            right: 20,
            child: IconButton(
              icon: const Icon(Icons.language, color: Colors.white),
              onPressed: controllerLang.toggleLang,
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: TextButton(
              onPressed: () {},
              child: Text(
                "91".tr,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ] else ...[
          Positioned(
            top: 20,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.language, color: Colors.white),
              onPressed: controllerLang.toggleLang,
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: TextButton(
              onPressed: () {},
              child: Text(
                "91".tr,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
        Positioned(
          bottom: 50,
          left: 20,
          right: 20,
          child: Column(
            children: [
              Text(
                page.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                page.description,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 30),
              DotsIndicator(
                currentPage: _currentPage,
                totalPages: onboardingPages.length,
              ),
              const SizedBox(height: 30),
              NextButton(
                isLastPage: _currentPage == onboardingPages.length - 1,
                onPressed: _nextPage,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
