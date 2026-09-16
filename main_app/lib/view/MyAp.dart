// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:flutter/material.dart';
// import 'Booking.dart';
// import 'FavoritesPage.dart';
// import 'HomePage.dart';
// import 'MessagesPage.dart';
// import 'ProfileScreen.dart';
// import 'MyBookingsScreen.dart';
// import 'package:get/get.dart';
// import '../controllers/accounts_controllers/refresh_controller.dart';
// import '../controllers/accounts_controllers/me_controller.dart';

// import 'MyFlats.dart';
// import '../models/flat_model.dart';

// bool isAvailable(
//   FlatModel flat,
//   DateTime from,
//   DateTime to,
//   List<Booking> bookings,
// ) {
//   for (var b in bookings) {
//     if (b.flat.id == flat.id) {
//       if (from.isBefore(b.to) && to.isAfter(b.from)) {
//         return false;
//       }
//     }
//   }
//   return true;
// }

// List<Booking> bookings = [];
// String currentUser = "user1";

// class MyAp extends StatefulWidget {
//   const MyAp({super.key});
//   @override
//   State createState() => MyApState();
// }

// class MyApState extends State<MyAp> {
//   int selectedIndex = 0;
//   final List<FlatModel> favoriteList = [];

//   @override
//   void initState() {
//     super.initState();
//     if (!Get.isRegistered<RefreshController>()) {
//       Get.put(RefreshController());
//     }
//     if (!Get.isRegistered<MeController>()) {
//       Get.put(MeController());
//       Get.find<MeController>().getUser();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final List _pages = [
//       HomePage(
//         onAddFavorite: (FlatModel item) {
//           setState(() {
//             if (!favoriteList.any((e) => e.id == item.id)) {
//               favoriteList.add(item);
//             }
//           });
//         },
//         favoriteList: favoriteList,
//       ),
//       FavoritesPage(
//         favorites: favoriteList,
//         onRemove: (index) {
//           setState(() {
//             favoriteList.removeAt(index);
//           });
//         },
//       ),
//       MessagesPage(),
//       Myflats(),
//       MyBookingsScreen(),
//       ProfileScreen(),
//     ];

//     return Scaffold(
//       bottomNavigationBar: CurvedNavigationBar(
//         height: 75,
//         backgroundColor: Colors.white,
//         color:const Color(0xFF121212),
//         animationDuration: const Duration(milliseconds: 500),
//         onTap: (int index) {
//           setState(() {
//             selectedIndex = index;
//           });
//         },
//         items: const [
//           Icon(Icons.home, color: Colors.white),
//           Icon(Icons.favorite, color: Colors.white),
//           Icon(Icons.message, color: Colors.white),
//           Icon(Icons.view_agenda, color: Colors.white),
//           Icon(Icons.calendar_month, color: Colors.white),
//           Icon(Icons.person, color: Colors.white),
//         ],
//       ),
//       body: _pages[selectedIndex],
//     );
//   }
// }
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'Booking.dart';
import 'FavoritesPage.dart';
import 'HomePage.dart';
import 'MessagesPage.dart';
import 'ProfileScreen.dart';
import 'MyBookingsScreen.dart';
import 'package:get/get.dart';
import '../controllers/accounts_controllers/refresh_controller.dart';
import '../controllers/accounts_controllers/me_controller.dart';

import 'MyFlats.dart';
import '../models/flat_model.dart';

import '../controllers/favourites_controllers/add_favourite_controller.dart';
import '../controllers/favourites_controllers/remove_favourite_controller.dart';
import '../controllers/favourites_controllers/show_favourites_controller.dart';

bool isAvailable(
  FlatModel flat,
  DateTime from,
  DateTime to,
  List<Booking> bookings,
) {
  for (var b in bookings) {
    if (b.flat.id == flat.id) {
      if (from.isBefore(b.to) && to.isAfter(b.from)) {
        return false;
      }
    }
  }
  return true;
}

List<Booking> bookings = [];
String currentUser = "user1";

class MyAp extends StatefulWidget {
  const MyAp({super.key});
  @override
  State createState() => MyApState();
}

class MyApState extends State<MyAp> {
  int selectedIndex = 0;

  final addFavouriteController = Get.put(AddFavouriteController());
  final removeFavouriteController = Get.put(RemoveFavouriteController());
  final showFavouritesController = Get.put(ShowFavouritesController());

  @override
  void initState() {
    super.initState();
    if (!Get.isRegistered<RefreshController>()) {
      Get.put(RefreshController());
    }
    if (!Get.isRegistered<MeController>()) {
      Get.put(MeController());
      Get.find<MeController>().getUser();
    }
    showFavouritesController.loadFavourites();
  }

  @override
  Widget build(BuildContext context) {
    final List pages = [
      const HomePage(),
      FavoritesPage(),
      MessagesPage(),
      Myflats(),
      MyBookingsScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 75,
        backgroundColor: Colors.white,
        color: const Color(0xFF121212),
        animationDuration: const Duration(milliseconds: 500),
        onTap: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.favorite, color: Colors.white),
          Icon(Icons.message, color: Colors.white),
          Icon(Icons.view_agenda, color: Colors.white),
          Icon(Icons.calendar_month, color: Colors.white),
          Icon(Icons.person, color: Colors.white),
        ],
      ),
      body: pages[selectedIndex],
    );
  }
}
