import 'package:flutter/material.dart';
import '../models/flat_model.dart';
import 'package:get/get.dart';

import 'BookingPage.dart';
import 'Booking.dart';

import '../../controllers/favourites_controllers/add_favourite_controller.dart';
import '../../controllers/favourites_controllers/remove_favourite_controller.dart';
import '../../controllers/favourites_controllers/show_favourites_controller.dart';
import '../../controllers/flats_controllers/show_flat_average_rating_controller.dart';

class FlatDetailsScreen extends StatefulWidget {
  final FlatModel flat;

  const FlatDetailsScreen({super.key, required this.flat});

  @override
  State<FlatDetailsScreen> createState() => FlatDetailsScreenState();
}

class FlatDetailsScreenState extends State<FlatDetailsScreen> {
  final List<Booking> bookings = [];

  final addFavouriteController = Get.put(AddFavouriteController());
  final removeFavouriteController = Get.put(RemoveFavouriteController());
  final showFavouritesController = Get.put(ShowFavouritesController());
  final showFlatAverageRatingController = Get.put(
    ShowFlatAverageRatingController(),
  );
  @override
  void initState() {
    super.initState();
    showFavouritesController.loadFavourites();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3.5,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                    child: Image.network(
                      widget.flat.flatImage ?? "images/home.jpg",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: Container(
                    width: 50,
                    height: 50,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Obx(() {
                      final isFav = showFavouritesController.favourites.any(
                        (f) => f['id'] == widget.flat.id,
                      );

                      return IconButton(
                        icon: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: isFav ? Colors.red : Colors.black,
                          size: 25.0,
                        ),
                        onPressed: () async {
                          if (isFav) {
                            await removeFavouriteController.removeFavourite(
                              widget.flat.id,
                            );
                          } else {
                            await addFavouriteController.addFavourite(
                              widget.flat.id,
                            );
                          }
                          await showFavouritesController.loadFavourites();
                        },
                      );
                    }),
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 20,
                  child: Container(
                    width: 50,
                    height: 50,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 24.0,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                " ${widget.flat.governorate}",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Wrap(
                spacing: 4,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    "    ${widget.flat.city}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "    ${widget.flat.address}",
                    style: const TextStyle(color: Colors.black, fontSize: 17),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.all(10),
              child: Wrap(
                spacing: 4,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Icon(
                    Icons.elevator,
                    color: widget.flat.hasElevator
                        ? const Color.fromRGBO(6, 17, 53, 1)
                        : Colors.grey,
                    size: 50,
                  ),
                  const SizedBox(width: 10),
                  Icon(
                    Icons.home,
                    color: widget.flat.isFurnished
                        ? const Color.fromRGBO(6, 17, 53, 1)
                        : Colors.grey,
                    size: 50,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),
            Wrap(
              spacing: 4,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Wrap(
                  children: [
                    Text(
                      "21".tr,
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    Text(
                      " : ${widget.flat.rooms}",
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Wrap(
                    children: [
                      Text(
                        "  ${widget.flat.space}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "31".tr,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Wrap(
                  children: [
                    Text(
                      "25".tr,
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    Text(
                      " : ${widget.flat.floor}",
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),
            Text(
              "  Available from: ${widget.flat.availableDate}",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 20),
            Text(
              "  ${widget.flat.price}\$",
              style: const TextStyle(
                color: Color.fromRGBO(6, 17, 53, 1),
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Obx(() {
              if (showFlatAverageRatingController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (showFlatAverageRatingController.errorMessage.isNotEmpty) {
                return Text(
                  showFlatAverageRatingController.errorMessage.value,
                  style: const TextStyle(color: Colors.red),
                );
              }

              final rating =
                  showFlatAverageRatingController.averageRating.value;

              return Row(
                children: [
                  const SizedBox(width: 10),
                  Icon(Icons.star, color: Colors.amber),
                  Text(
                    "$rating / 5",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              );
            }),

            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BookingPage(
                          flat: widget.flat,
                          bookings: bookings,
                          onBooked: (booking) {
                            bookings.add(booking);
                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(SnackBar(content: Text("56".tr)));
                          },
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(6, 17, 53, 1),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Text("29".tr, style: const TextStyle(fontSize: 20)),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
