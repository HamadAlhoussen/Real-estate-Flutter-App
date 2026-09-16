import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_app/view/WelcomeScreen.dart';
// import 'package:firebase_core/firebase_core.dart';

import 'controllers/accounts_controllers/forgot_password_controller.dart';
import 'controllers/accounts_controllers/login_controller.dart';
import 'controllers/notifications_controllers/pusher_controller.dart';
import 'locale/locale.dart';
import 'locale/locale_controller.dart';

import '../../controllers/accounts_controllers/me_controller.dart';
import '../../controllers/accounts_controllers/refresh_controller.dart';
import '../../controllers/accounts_controllers/update_user_controller.dart';

import '../../controllers/flats_controllers/search_flats_controller.dart';
import '../../controllers/flats_controllers/show_flat_by_id_controller.dart';
import '../../controllers/flats_controllers/show_flats_by_user_id_controller.dart';
import '../../controllers/flats_controllers/update_flat_controller.dart';
import '../../controllers/flats_controllers/create_flat_controller.dart';
import '../../controllers/flats_controllers/delete_flat_controller.dart';
import '../../controllers/flats_controllers/create_flat_rating_controller.dart';
import '../../controllers/flats_controllers/show_flat_average_rating_controller.dart';

import '../../view/LoginScreen.dart';
import '../../view/MyAp.dart';

import '../../utils/app_preferances.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //  await Firebase.initializeApp();

  Get.put(RefreshController(), permanent: true);
  Get.put(MyLocaleController(), permanent: true);
  Get.put(ForgotPasswordController(), permanent: true);
  Get.put(LoginController(), permanent: true);
  Get.lazyPut(() => MeController(), fenix: true);
  Get.lazyPut(() => SearchFlatsController(), fenix: true);
  Get.lazyPut(() => ShowFlatByIdController(), fenix: true);
  Get.lazyPut(() => ShowFlatsByUserIdController(), fenix: true);
  Get.lazyPut(() => UpdateFlatController(), fenix: true);
  Get.lazyPut(() => CreateFlatController(), fenix: true);
  Get.lazyPut(() => DeleteFlatController(), fenix: true);
  Get.lazyPut(() => CreateFlatRatingController(), fenix: true);
  Get.lazyPut(() => ShowFlatAverageRatingController(), fenix: true);
  Get.lazyPut(() => UpdateUserController(), fenix: true);

  final isFirstTime = await AppPreferences.isFirstTime();
  final refreshController = Get.find<RefreshController>();
  final isTokenValid = await refreshController.checkTokenValidity();

  if (!isFirstTime) {
    Get.put(PusherController(), permanent: true);
  }
  Widget initialScreen;
  if (isTokenValid) {
    initialScreen = const MyAp();
  } else if (isFirstTime) {
    initialScreen = const WelcomeScreen();
  } else {
    initialScreen = const LoginScreen();
  }

  runApp(MyApp(initialScreen: initialScreen));
}

class MyApp extends StatelessWidget {
  final Widget initialScreen;
  const MyApp({super.key, required this.initialScreen});

  @override
  Widget build(BuildContext context) {
    final localeController = Get.find<MyLocaleController>();

    return GetMaterialApp(
      theme: ThemeData.light().copyWith(
        textTheme: ThemeData.light().textTheme.apply(fontFamily: 'Oswald'),
      ),

      darkTheme: ThemeData.dark().copyWith(
        textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'Oswald'),
      ),

      themeMode: ThemeMode.light,
      locale: localeController.initialLang,
      translations: MyLocale(),
      debugShowCheckedModeBanner: false,
      home: initialScreen,
    );
  }
}

//yara's main

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../view/MyAp.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   runApp(
//     const MyApp(
//       initialScreen: MyAp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   final Widget initialScreen;
//   const MyApp({super.key, required this.initialScreen});

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       theme: ThemeData(fontFamily: 'Oswald'),
//       debugShowCheckedModeBanner: false,
//       home: initialScreen,
//     );
//   }
// }

//admin main

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'locale/locale.dart';
// import 'locale/locale_controller.dart';
// import '../../controllers/accounts_controllers/me_controller.dart';
// import '../../controllers/accounts_controllers/refresh_controller.dart';
// import '../../view/LoginScreen.dart';
// import '../../utils/app_preferances.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   Get.put(RefreshController(), permanent: true);
//   Get.put(MyLocaleController(), permanent: true);
//   Get.lazyPut(() => MeController(), fenix: true);
//   await AppPreferences.clearToken();

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final localeController = Get.find<MyLocaleController>();

//     return GetMaterialApp(
//       theme: ThemeData(fontFamily: 'Oswald'),
//       locale: localeController.initialLang,
//       translations: MyLocale(),
//       debugShowCheckedModeBanner: false,
//       home: const LoginScreen(),
//     );
//   }
// }
