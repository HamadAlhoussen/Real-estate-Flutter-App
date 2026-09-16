// import 'package:flutter/material.dart';
// import 'FlatDetailsScreen.dart';
// import 'BookingPage.dart';
// import 'dart:ui';
// import 'package:get/get.dart';
// import '../models/flat_model.dart';

// class HomeItem extends StatefulWidget {
//   final FlatModel flat;
//   final Function(FlatModel) onAddFavorite;

//   const HomeItem({super.key, required this.flat, required this.onAddFavorite});

//   @override
//   State<HomeItem> createState() => HomeItemState();
// }

// class HomeItemState extends State<HomeItem> {
//   bool isFavorite = false;

//   void toggleFavorite() {
//     setState(() {
//       isFavorite = !isFavorite;
//     });
//     if (isFavorite) {
//       widget.onAddFavorite(widget.flat);
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text("79".tr)));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final flat = widget.flat;

//     return GestureDetector(
//       onTap: () {
//         showDialog(
//           context: context,
//           barrierDismissible: true,
//           barrierColor: Colors.transparent,
//           builder: (context) {
//             return Stack(
//               children: [
//                 BackdropFilter(
//                   filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
//                   child: Container(color: Colors.black.withOpacity(0.2)),
//                 ),
//                 Center(
//                   child: Dialog(
//                     backgroundColor: Colors.transparent,
//                     insetPadding: const EdgeInsets.all(16),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(30),
//                       child: Container(
//                         height: MediaQuery.of(context).size.height * 0.8,
//                         color: Colors.white,
//                         child: FlatDetailsScreen(
//                           flat: flat,
//                           onFavorite: toggleFavorite,
//                           isFavorite: isFavorite,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//       child: Container(
//         width: 160,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: const [
//             BoxShadow(
//               color: Colors.black12,
//               blurRadius: 5,
//               offset: Offset(2, 3),
//             ),
//           ],
//         ),
//         child: Column(
//           children: [
//             Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius: const BorderRadius.vertical(
//                     top: Radius.circular(20),
//                   ),
//                   child: Image.network(
//                     flat.flatImage ?? "images/home.jpg",
//                     height: 130,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) {
//                       return Image.asset(
//                         "images/home.jpg",
//                         height: 130,
//                         fit: BoxFit.cover,
//                       );
//                     },
//                   ),
//                 ),
//                 if (Get.locale?.languageCode == 'en') ...[
//                   Positioned(
//                     top: 8,
//                     right: 8,
//                     child: IconButton(
//                       icon: Icon(
//                         isFavorite ? Icons.favorite : Icons.favorite_border,
//                         color: isFavorite ? Colors.red : Colors.white,
//                         size: 28,
//                       ),
//                       onPressed: toggleFavorite,
//                     ),
//                   ),
//                 ] else ...[
//                   Positioned(
//                     top: 8,
//                     left: 8,
//                     child: IconButton(
//                       icon: Icon(
//                         isFavorite ? Icons.favorite : Icons.favorite_border,
//                         color: isFavorite ? Colors.red : Colors.white,
//                         size: 28,
//                       ),
//                       onPressed: toggleFavorite,
//                     ),
//                   ),
//                 ],
//               ],
//             ),
//             const SizedBox(height: 6),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8),
//               child: Column(
//                 children: [
//                   Text(
//                     flat.governorate,
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18,
//                       color: const Color(0xFF121212),
//                     ),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   Text(
//                     "${flat.price}\$",
//                     style: const TextStyle(
//                       color: Color.fromRGBO(71, 74, 71, 1),
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 3),
//             Expanded(
//               child: Container(
//                 alignment: Alignment.bottomCenter,
//                 padding: const EdgeInsets.symmetric(horizontal: 8),
//                 child: SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => BookingPage(
//                             flat: flat,
//                             bookings: [],
//                             onBooked: (booking) {
//                               setState(() {});
//                             },
//                           ),
//                         ),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color.fromRGBO(6, 17, 53, 1),
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     child: Text("29".tr, style: const TextStyle(fontSize: 15)),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'FlatDetailsScreen.dart';
import 'BookingPage.dart';
import 'dart:ui';
import 'package:get/get.dart';
import '../models/flat_model.dart';

import '../../controllers/favourites_controllers/add_favourite_controller.dart';
import '../../controllers/favourites_controllers/remove_favourite_controller.dart';
import '../../controllers/favourites_controllers/show_favourites_controller.dart';

class HomeItem extends StatefulWidget {
  final FlatModel flat;

  const HomeItem({super.key, required this.flat});

  @override
  State<HomeItem> createState() => HomeItemState();
}

class HomeItemState extends State<HomeItem> {
  final addFavouriteController = Get.put(AddFavouriteController());
  final removeFavouriteController = Get.put(RemoveFavouriteController());
  final showFavouritesController = Get.put(ShowFavouritesController());

  @override
  void initState() {
    super.initState();
    showFavouritesController.loadFavourites();
  }

  @override
  Widget build(BuildContext context) {
    final flat = widget.flat;

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          barrierDismissible: true,
          barrierColor: Colors.transparent,
          builder: (context) {
            return Stack(
              children: [
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                  child: Container(color: Colors.black.withOpacity(0.2)),
                ),
                Center(
                  child: Dialog(
                    backgroundColor: Colors.transparent,
                    insetPadding: const EdgeInsets.all(16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.8,
                        color: Colors.white,
                        child: FlatDetailsScreen(flat: flat),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
      child: Container(
        width: 160,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: Offset(2, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  child: Image.network(
                    flat.flatImage ?? "images/home.jpg",
                    height: 130,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        "images/home.jpg",
                        height: 130,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
                Obx(() {
                  final isFav = showFavouritesController.favourites.any(
                    (f) => f['id'] == flat.id,
                  );

                  return Positioned(
                    top: 8,
                    right: Get.locale?.languageCode == 'en' ? 8 : null,
                    left: Get.locale?.languageCode == 'en' ? null : 8,
                    child: IconButton(
                      icon: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: isFav ? Colors.red : Colors.white,
                        size: 28,
                      ),
                      onPressed: () async {
                        if (isFav) {
                          await removeFavouriteController.removeFavourite(
                            flat.id,
                          );
                        } else {
                          await addFavouriteController.addFavourite(flat.id);
                        }
                        await showFavouritesController.loadFavourites();
                      },
                    ),
                  );
                }),
              ],
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Text(
                    flat.governorate,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF121212),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "${flat.price}\$",
                    style: const TextStyle(
                      color: Color.fromRGBO(71, 74, 71, 1),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 3),
            Expanded(
              child: Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BookingPage(
                            flat: flat,
                            bookings: [],
                            onBooked: (booking) {
                              setState(() {});
                            },
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(6, 17, 53, 1),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text("29".tr, style: const TextStyle(fontSize: 15)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
