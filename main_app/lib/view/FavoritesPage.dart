// import 'package:flutter/material.dart';
// import 'BookingPage.dart';
// import 'package:get/get.dart';
// import '../models/flat_model.dart';

// class FavoritesPage extends StatelessWidget {
//   final List<FlatModel> favorites;
//   final Function(int) onRemove;

//   const FavoritesPage({
//     super.key,
//     required this.favorites,
//     required this.onRemove,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: favorites.isEmpty
//           ? Center(
//               child: Container(
//                 height: 40,
//                 width: 300,
//                 decoration: BoxDecoration(
//                   color: const Color.fromRGBO(14, 1, 32, 1),
//                   borderRadius: BorderRadius.circular(18),
//                 ),
//                 child: Center(
//                   child: Text(
//                     "33".tr,
//                     style: const TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//             )
//           : ListView.builder(
//               padding: const EdgeInsets.all(15),
//               itemCount: favorites.length,
//               itemBuilder: (context, i) {
//                 final flat = favorites[i];
//                 return Card(
//                   margin: const EdgeInsets.symmetric(vertical: 8),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   elevation: 5,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             ClipRRect(
//                               borderRadius: BorderRadius.circular(12),
//                               child: Image.network(
//                                 flat.flatImage ?? "images/home.jpg",
//                                 width: 60,
//                                 height: 60,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                             const SizedBox(width: 10),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     flat.governorate,
//                                     style: const TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 16,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 4),
//                                   Text(
//                                     "${flat.price}\$",
//                                     style: const TextStyle(
//                                       color: Colors.green,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             IconButton(
//                               icon: const Icon(Icons.delete, color: Colors.red),
//                               onPressed: () {
//                                 onRemove(i);
//                               },
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 8),
//                         SizedBox(
//                           width: double.infinity,
//                           child: ElevatedButton(
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (_) => BookingPage(
//                                     flat: flat,
//                                     bookings: [],
//                                     onBooked: (booking) {},
//                                   ),
//                                 ),
//                               );
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: const Color.fromRGBO(
//                                 6,
//                                 10,
//                                 53,
//                                 1,
//                               ),
//                               foregroundColor: Colors.white,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                             ),
//                             child: Text("29".tr),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'BookingPage.dart';
import 'package:get/get.dart';

import '../controllers/favourites_controllers/show_favourites_controller.dart';
import '../controllers/favourites_controllers/remove_favourite_controller.dart';

import '../controllers/flats_controllers/show_flat_by_id_controller.dart';

class FavoritesPage extends StatelessWidget {
  FavoritesPage({super.key});

  final showFavouritesController = Get.put(ShowFavouritesController());
  final removeFavouriteController = Get.put(RemoveFavouriteController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() {
        final favorites = showFavouritesController.favourites;

        if (favorites.isEmpty) {
          return Center(
            child: Container(
              height: 40,
              width: 300,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(14, 1, 32, 1),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Center(
                child: Text(
                  "33".tr,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(15),
          itemCount: favorites.length,
          itemBuilder: (context, i) {
            final fav = favorites[i];
            final flatId = fav['flat_id'];

            final flatController = Get.put(
              ShowFlatByIdController(),
              tag: "flat_$flatId",
            );
            flatController.fetchFlatById(flatId);

            return Obx(() {
              final flat = flatController.flat.value;

              if (flat == null) {
                return const Center(child: CircularProgressIndicator());
              }

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Column(
                    children: [
                      Wrap(
                        spacing: 1,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Wrap(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  flat.flatImage ?? "images/home.jpg",
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    flat.governorate,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "${flat.price}\$",
                                    style: const TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              await removeFavouriteController.removeFavourite(
                                fav['id'],
                              );
                              await showFavouritesController.loadFavourites();
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BookingPage(
                                  flat: flat,
                                  bookings: [],
                                  onBooked: (booking) {},
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(6, 10, 53, 1),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text("29".tr),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
          },
        );
      }),
    );
  }
}
