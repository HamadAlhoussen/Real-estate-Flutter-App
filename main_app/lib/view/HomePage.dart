import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'FilterButton.dart';
import 'HorizontalSection.dart';

import '../controllers/accounts_controllers/logout_controller.dart';
import '../controllers/flats_controllers/search_flats_controller.dart';
import '../locale/locale_controller.dart';

import '../controllers/favourites_controllers/add_favourite_controller.dart';
import '../controllers/favourites_controllers/remove_favourite_controller.dart';
import '../controllers/favourites_controllers/show_favourites_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String governorate = "18";
  String location = "59";
  String price = "19";
  String rooms = "21";
  String elevator = "23";
  String furnished = "24";
  String floor = "25";

  String? selectedGovernorate;
  String? selectedCity;
  double? selectedPrice;
  int? selectedRooms;
  int? selectedFloor = 1;
  bool? selectedHasElevator;
  bool? selectedIsFurnished;

  final Map<String, String> governorateMap = {
    "64".tr: "Damascus",
    "65".tr: "Aleppo",
    "66".tr: "Lattakia",
    "67".tr: "Homs",
  };

  final Map<String, String> cityMap = {
    "61".tr: "Urban",
    "62".tr: "Suburban",
    "63".tr: "Rural",
  };

  final Map<String, int> roomsMap = {"1": 1, "2": 2, "3": 3, "4": 4, "5": 5};
  final Map<String, int> spaceMap = {"81".tr: 100, "82".tr: 150, "83".tr: 200};
  final Map<String, int> floorMap = {"1": 1, "2": 2, "3": 3, "80".tr: 4};
  final Map<String, bool> elevatorMap = {"Yes": true, "No": false};
  final Map<String, bool> furnishedMap = {"Yes": true, "No": false};

  final String placeholderImg = "images/home.jpg";

  final logoutController = Get.put(LogoutController());
  final searchController = Get.put(SearchFlatsController());

  final addFavouriteController = Get.put(AddFavouriteController());
  final removeFavouriteController = Get.put(RemoveFavouriteController());
  final showFavouritesController = Get.put(ShowFavouritesController());

  @override
  void initState() {
    super.initState();
    searchController.searchFlats(noFilter: true);
    showFavouritesController.loadFavourites();
  }

  @override
  Widget build(BuildContext context) {
    final MyLocaleController controllerLang = Get.find();

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  child: Image.asset(
                    placeholderImg,
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                if (Get.locale?.languageCode == 'en') ...[
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
                    child: IconButton(
                      icon: const Icon(Icons.color_lens, color: Colors.white),
                      onPressed: () {
                        if (Get.isDarkMode) {
                          Get.changeTheme(ThemeData.light());
                        } else {
                          Get.changeTheme(ThemeData.dark());
                        }
                      },
                    ),
                  ),
                ] else ...[
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
                    child: IconButton(
                      icon: const Icon(Icons.color_lens, color: Colors.white),
                      onPressed: () {
                        if (Get.isDarkMode) {
                          Get.changeTheme(ThemeData.light());
                        } else {
                          Get.changeTheme(ThemeData.dark());
                        }
                      },
                    ),
                  ),
                ],
                Positioned(
                  top: 70,
                  left: 68,
                  right: 42,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          "17".tr,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        FilterButton(
                          label: governorate.tr,
                          options: ["64".tr, "65".tr, "66".tr, "67".tr],
                          onSelected: (val) {
                            setState(() {
                              governorate = val;
                              selectedGovernorate = val;
                            });
                          },
                        ),
                        const SizedBox(width: 8),
                        FilterButton(
                          label: location.tr,
                          options: ["61".tr, "62".tr, "63".tr],
                          onSelected: (val) {
                            setState(() {
                              location = val;
                              selectedCity = cityMap[val];
                            });
                          },
                        ),
                        const SizedBox(width: 8),
                        FilterButton(
                          label: rooms.tr,
                          options: [" 1 ", " 2 ", " 3 ", " 4 ", " 5 "],
                          onSelected: (val) {
                            setState(() {
                              rooms = val;
                              selectedRooms = int.tryParse(
                                val.replaceAll(RegExp(r'[^0-9]'), ''),
                              );
                            });
                          },
                        ),
                        const SizedBox(width: 8),
                        FilterButton(
                          label: elevator.tr,
                          options: const ["Yes", "No"],
                          onSelected: (val) {
                            setState(() {
                              elevator = val;
                              selectedHasElevator = (val == "Yes");
                            });
                          },
                        ),
                        const SizedBox(width: 8),
                        FilterButton(
                          label: furnished.tr,
                          options: const ["Yes", "No"],
                          onSelected: (val) {
                            setState(() {
                              furnished = val;
                              selectedIsFurnished = (val == "Yes");
                            });
                          },
                        ),
                        const SizedBox(width: 8),
                        TextButton(
                          onPressed: () {
                            final hasFilters =
                                selectedGovernorate != null ||
                                selectedCity != null ||
                                selectedPrice != null ||
                                selectedRooms != null ||
                                selectedFloor != null ||
                                selectedHasElevator != null ||
                                selectedIsFurnished != null;

                            searchController.searchFlats(
                              governorate: selectedGovernorate,
                              city: selectedCity,
                              price: selectedPrice,
                              rooms: selectedRooms,
                              floor: selectedFloor,
                              hasElevator: selectedHasElevator,
                              isFurnished: selectedIsFurnished,
                              noFilter: !hasFilters,
                            );
                          },
                          child: Text(
                            "Filter",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 19,
                              color: Color.fromRGBO(255, 179, 0, 1),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              governorate = "18";
                              location = "59";
                              price = "19";
                              rooms = "21";
                              elevator = "23";
                              furnished = "24";
                              floor = "25";

                              selectedGovernorate = null;
                              selectedCity = null;
                              selectedPrice = null;
                              selectedRooms = null;
                              selectedFloor = null;
                              selectedHasElevator = null;
                              selectedIsFurnished = null;
                            });

                            searchController.searchFlats(noFilter: true);
                          },
                          child: Text(
                            "90".tr,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 19,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            Obx(() {
              if (searchController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (searchController.errorMessage.isNotEmpty) {
                return Center(child: Text(searchController.errorMessage.value));
              }

              return Column(
                children: [
                  HorizontalSection(
                    title: "26".tr,
                    homes: searchController.luxuryFlats,
                  ),
                  const SizedBox(height: 12),
                  HorizontalSection(
                    title: "27".tr,
                    homes: searchController.standardFlats,
                  ),
                  const SizedBox(height: 12),
                  HorizontalSection(
                    title: "28".tr,
                    homes: searchController.bedFlats,
                  ),
                  const SizedBox(height: 12),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
