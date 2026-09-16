import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/GlowingCircle.dart';
import '../widgets/Background.dart';
import 'EditAppartment.dart';
import '../../controllers/flats_controllers/show_flats_by_user_id_controller.dart';
import '../../controllers/flats_controllers/delete_flat_controller.dart';
import 'dart:ui';
import 'Add.dart';
import 'ApproveFlatsRequestsScreen.dart';

class Myflats extends StatefulWidget {
  const Myflats({super.key});

  @override
  State<Myflats> createState() => MyflatsState();
}

class MyflatsState extends State<Myflats> {
  final flatsController = Get.put(ShowFlatsByUserIdController());
  final deleteController = Get.put(DeleteFlatController());

  @override
  void initState() {
    super.initState();
    flatsController.fetchFlatsByUserId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Background(),
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
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: Column(
                    children: [
                      if (Get.locale?.languageCode == 'en') ...[
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            icon: const Icon(Icons.add, color: Colors.white),
                            onPressed: () => Get.to(() => const Add()),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: const Icon(
                              Icons.request_page,
                              color: Colors.white,
                            ),
                            onPressed: () =>
                                Get.to(() => const FlatsRequestsScreen()),
                          ),
                        ),
                      ] else ...[
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: const Icon(Icons.add, color: Colors.white),
                            onPressed: () => Get.to(() => const Add()),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            icon: const Icon(
                              Icons.request_page,
                              color: Colors.white,
                            ),
                            onPressed: () =>
                                Get.to(() => const FlatsRequestsScreen()),
                          ),
                        ),
                      ],
                      const SizedBox(height: 10),
                      Expanded(
                        child: Obx(() {
                          if (flatsController.isLoading.value) {
                            return Center(
                              child: const CircularProgressIndicator(),
                            );
                          }
                          if (flatsController.flats.isEmpty) {
                            return Text(
                              "42".tr,
                              style: TextStyle(color: Colors.white),
                            );
                          }
                          return ListView.builder(
                            itemCount: flatsController.flats.length,
                            itemBuilder: (context, index) {
                              final flat = flatsController.flats[index];
                              return SingleChildScrollView(
                                child: Card(
                                  color: const Color.fromARGB(
                                    255,
                                    255,
                                    255,
                                    255,
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 6,
                                  ),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    height:
                                        MediaQuery.of(context).size.height *
                                        0.17,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        alignment: WrapAlignment.spaceBetween,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            child:
                                                (flat.flatImage != null &&
                                                    flat.flatImage!.startsWith(
                                                      'http',
                                                    ))
                                                ? Image.network(
                                                    flat.flatImage!,
                                                    height: 90,
                                                    width: 85,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Image.asset(
                                                    "images/home.jpg",
                                                    height: 90,
                                                    width: 85,
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                          SizedBox(
                                            width:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                0.1,
                                            child: Column(
                                              children: [
                                                Text(
                                                  flat.governorate,
                                                  maxLines: 2,
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  "${flat.price} \$",
                                                  maxLines: 2,
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Expanded(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                IconButton(
                                                  icon: const Icon(
                                                    Icons.edit,
                                                    color: Colors.blue,
                                                    size: 20,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (_) =>
                                                            EditApartment(
                                                              flat: flat,
                                                            ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                const SizedBox(height: 8),
                                                IconButton(
                                                  icon: const Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                    size: 20,
                                                  ),
                                                  onPressed: () async {
                                                    final confirm =
                                                        await showDialog<bool>(
                                                          context: context,
                                                          builder: (ctx) => AlertDialog(
                                                            title: Text(
                                                              "43".tr,
                                                            ),
                                                            content: Text(
                                                              "44".tr,
                                                            ),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () =>
                                                                    Navigator.of(
                                                                      ctx,
                                                                    ).pop(
                                                                      false,
                                                                    ),
                                                                child: Text(
                                                                  "30".tr,
                                                                ),
                                                              ),
                                                              ElevatedButton(
                                                                onPressed: () =>
                                                                    Navigator.of(
                                                                      ctx,
                                                                    ).pop(true),
                                                                child: Text(
                                                                  "45".tr,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                    if (confirm == true) {
                                                      await deleteController
                                                          .deleteFlat(flat.id);
                                                      flatsController.flats
                                                          .removeAt(index);
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }),
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
