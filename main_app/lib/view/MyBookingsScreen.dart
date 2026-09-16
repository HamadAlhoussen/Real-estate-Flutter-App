// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/reservations_controllers/show_reservations_controller.dart';
// import '../controllers/reservations_controllers/update_reservation_controller.dart';
// import '../controllers/reservations_controllers/cancel_reservation_controller.dart';
// import '../widgets/BookingScreenWidgets.dart';

// class MyBookingsScreen extends StatefulWidget {
//   const MyBookingsScreen({super.key});

//   @override
//   State<MyBookingsScreen> createState() => _MyBookingsScreenState();
// }

// class _MyBookingsScreenState extends State<MyBookingsScreen> {
//   final ShowReservationController showController = Get.put(
//     ShowReservationController(),
//   );
//   final UpdateReservationController updateController = Get.put(
//     UpdateReservationController(),
//   );
//   final CancelReservationController cancelController = Get.put(
//     CancelReservationController(),
//   );

//   int selectedTab = 0;

//   @override
//   void initState() {
//     super.initState();
//     _loadReservations();
//   }

//   Future<void> _loadReservations() async {
//     await showController.loadReservations();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final now = DateTime.now();

//     return Scaffold(
//       appBar: AppBar(
//         title: Center(
//           child: Text(
//             "36".tr,
//             style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//           ),
//         ),
//       ),
//       body: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 20.0),
//         child: Column(
//           children: [
//             const SizedBox(height: 10),
//             Row(
//               children: [
//                 Expanded(
//                   child: Material(
//                     elevation: selectedTab == 0 ? 2.0 : 50.0,
//                     borderRadius: BorderRadius.circular(10),
//                     child: BookingScreenWidgets(
//                       wid: selectedTab == 0 ? 165.0 : 200.0,
//                       path: "images/incoming.jpg",
//                       tex: "38".tr,
//                       onTap: () => setState(() => selectedTab = 0),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 20.0),
//                 Expanded(
//                   child: Material(
//                     elevation: selectedTab == 1 ? 2.0 : 50.0,
//                     borderRadius: BorderRadius.circular(10),
//                     child: BookingScreenWidgets(
//                       wid: selectedTab == 1 ? 165.0 : 200.0,
//                       path: "images/past.jpg",
//                       tex: "37".tr,
//                       onTap: () => setState(() => selectedTab = 1),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 15),
//             Expanded(
//               child: Obx(() {
//                 if (showController.isLoading.value) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//                 if (showController.errorMessage.isNotEmpty) {
//                   return Center(child: Text(showController.errorMessage.value));
//                 }
//                 if (showController.reservations.isEmpty) {
//                   return Center(child: Text("86".tr));
//                 }

//                 final current = showController.reservations
//                     .where(
//                       (r) =>
//                           DateTime.tryParse(
//                             r["end_time"] ?? '',
//                           )?.isAfter(now) ??
//                           false,
//                     )
//                     .toList();
//                 final past = showController.reservations
//                     .where(
//                       (r) =>
//                           DateTime.tryParse(
//                             r["end_time"] ?? '',
//                           )?.isBefore(now) ??
//                           false,
//                     )
//                     .toList();
//                 final list = selectedTab == 0 ? current : past;
//                 if (list.isEmpty) {
//                   return Center(
//                     child: Text(selectedTab == 0 ? "87".tr : "88".tr),
//                   );
//                 }
//                 return ListView.builder(
//                   itemCount: list.length,
//                   itemBuilder: (_, i) =>
//                       _reservationTile(list[i], isPast: selectedTab == 1),
//                 );
//               }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _reservationTile(Map<String, dynamic> r, {required bool isPast}) {
//     final start = DateTime.tryParse(r["start_time"] ?? '') ?? DateTime.now();
//     final end = DateTime.tryParse(r["end_time"] ?? '') ?? DateTime.now();

//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       child: ListTile(
//         title: Text("Flat ID: ${r["flat_id"] ?? 'N/A'}"),
//         subtitle: Text(
//           "Price: ${r["price"] ?? 'N/A'} | Status: ${r["status"] ?? 'N/A'}\n"
//           "From: ${start.toLocal().toString().split(' ')[0]} "
//           "To: ${end.toLocal().toString().split(' ')[0]}",
//         ),
//         trailing: isPast
//             ? null
//             : Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.edit, color: Colors.orange),
//                     onPressed: () async {
//                       DateTime? newFrom = await showDatePicker(
//                         context: context,
//                         initialDate: start,
//                         firstDate: DateTime.now(),
//                         lastDate: DateTime(2030),
//                       );
//                       if (newFrom == null) return;

//                       DateTime? newTo = await showDatePicker(
//                         context: context,
//                         initialDate: end,
//                         firstDate: newFrom,
//                         lastDate: DateTime(2030),
//                       );
//                       if (newTo == null) return;

//                       await updateController.updateReservation(
//                         r['id'],
//                         newFrom.toIso8601String(),
//                         newTo.toIso8601String(),
//                       );

//                       if (updateController.errorMessage.isNotEmpty) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text(updateController.errorMessage.value),
//                           ),
//                         );
//                       } else {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text('Booking updated successfully'),
//                           ),
//                         );
//                         _loadReservations();
//                       }
//                     },
//                   ),

//                   IconButton(
//                     icon: const Icon(Icons.cancel, color: Colors.red),
//                     onPressed: () async {
//                       await cancelController.cancelReservation(r['id']);

//                       if (cancelController.errorMessage.isNotEmpty) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text(cancelController.errorMessage.value),
//                           ),
//                         );
//                       } else {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text('Booking cancelled successfully'),
//                           ),
//                         );
//                         _loadReservations();
//                       }
//                     },
//                   ),
//                 ],
//               ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/flats_controllers/create_flat_rating_controller.dart';
// import '../controllers/flats_controllers/show_flat_average_rating_controller.dart';
// import '../controllers/reservations_controllers/show_reservations_controller.dart';
// import '../controllers/reservations_controllers/update_reservation_controller.dart';
// import '../controllers/reservations_controllers/cancel_reservation_controller.dart';
// import '../widgets/BookingScreenWidgets.dart';

// class MyBookingsScreen extends StatefulWidget {
//   const MyBookingsScreen({super.key});

//   @override
//   State<MyBookingsScreen> createState() => _MyBookingsScreenState();
// }

// class _MyBookingsScreenState extends State<MyBookingsScreen> {
//   final ShowReservationController showController = Get.put(
//     ShowReservationController(),
//   );
//   final UpdateReservationController updateController = Get.put(
//     UpdateReservationController(),
//   );
//   final CancelReservationController cancelController = Get.put(
//     CancelReservationController(),
//   );

//   int selectedTab = 0;

//   @override
//   void initState() {
//     super.initState();
//     _loadReservations();
//   }

//   Future<void> _loadReservations() async {
//     await showController.loadReservations();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // ignore: unused_local_variable
//     final now = DateTime.now();

//     return Scaffold(
//       appBar: AppBar(
//         title: Center(
//           child: Text(
//             "36".tr,
//             style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//           ),
//         ),
//       ),
//       body: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 20.0),
//         child: Column(
//           children: [
//             const SizedBox(height: 10),
//             Row(
//               children: [
//                 Expanded(
//                   child: Material(
//                     elevation: selectedTab == 0 ? 2.0 : 50.0,
//                     borderRadius: BorderRadius.circular(10),
//                     child: BookingScreenWidgets(
//                       wid: selectedTab == 0 ? 165.0 : 200.0,
//                       path: "images/incoming.jpg",
//                       tex: "38".tr,
//                       onTap: () => setState(() => selectedTab = 0),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 20.0),
//                 Expanded(
//                   child: Material(
//                     elevation: selectedTab == 1 ? 2.0 : 50.0,
//                     borderRadius: BorderRadius.circular(10),
//                     child: BookingScreenWidgets(
//                       wid: selectedTab == 1 ? 165.0 : 200.0,
//                       path: "images/past.jpg",
//                       tex: "37".tr,
//                       onTap: () => setState(() => selectedTab = 1),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 15),
//             Expanded(
//               child: Obx(() {
//                 if (showController.isLoading.value) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//                 if (showController.errorMessage.isNotEmpty) {
//                   return Center(child: Text(showController.errorMessage.value));
//                 }

//                 final list = selectedTab == 0
//                     ? showController.currentReservations
//                     : showController.pastReservations;

//                 if (list.isEmpty) {
//                   return Center(
//                     child: Text(selectedTab == 0 ? "87".tr : "88".tr),
//                   );
//                 }
//                 return ListView.builder(
//                   itemCount: list.length,
//                   itemBuilder: (_, i) =>
//                       _reservationTile(list[i], isPast: selectedTab == 1),
//                 );
//               }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _reservationTile(Map<String, dynamic> r, {required bool isPast}) {
//     final start = DateTime.tryParse(r["start_time"] ?? '') ?? DateTime.now();
//     final end = DateTime.tryParse(r["end_time"] ?? '') ?? DateTime.now();

//     final avgController = Get.put(ShowFlatAverageRatingController());
//     final ratingController = Get.put(CreateFlatRatingController());

//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       child: ListTile(
//         title: Text("Flat ID: ${r["flat_id"] ?? 'N/A'}"),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Price: ${r["price"] ?? 'N/A'} | Status: ${r["status"] ?? 'N/A'}\n"
//               "From: ${start.toLocal().toString().split(' ')[0]} "
//               "To: ${end.toLocal().toString().split(' ')[0]}",
//             ),
//             if (isPast)
//               Obx(() {
//                 avgController.fetchAverageRating(flatId: r["flat_id"]);
//                 return Text(
//                   "Average rating: ${avgController.averageRating.value.toStringAsFixed(1)}",
//                   style: const TextStyle(color: Colors.black54),
//                 );
//               }),
//           ],

//         ),
//         trailing: isPast
//             ? IconButton(
//                 icon: const Icon(Icons.star, color: Colors.amber),
//                 onPressed: () {
//                   showDialog(
//                     context: context,
//                     builder: (_) {
//                       int tempRating = 3;
//                       return AlertDialog(
//                         title: const Text("Rate this flat"),
//                         content: DropdownButton<int>(
//                           value: tempRating,
//                           items: List.generate(
//                             5,
//                             (i) => DropdownMenuItem(
//                               value: i + 1,
//                               child: Text("${i + 1} Stars"),
//                             ),
//                           ),
//                           onChanged: (val) {
//                             tempRating = val ?? 3;
//                           },
//                         ),
//                         actions: [
//                           TextButton(
//                             onPressed: () => Navigator.pop(context),
//                             child: const Text("Cancel"),
//                           ),
//                           ElevatedButton(
//                             onPressed: () async {
//                               await ratingController.rateFlat(
//                                 flatId: r["flat_id"],
//                                 rating: tempRating,
//                                 token: "",
//                               );
//                               Navigator.pop(context);
//                             },
//                             child: const Text("Submit"),
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 },
//               )
//             : Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.edit, color: Colors.orange),
//                     onPressed: () async {},
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.cancel, color: Colors.red),
//                     onPressed: () async {},
//                   ),
//                 ],
//               ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/flats_controllers/create_flat_rating_controller.dart';
import '../controllers/flats_controllers/show_flat_average_rating_controller.dart';
import '../controllers/reservations_controllers/show_reservations_controller.dart';
import '../controllers/reservations_controllers/update_reservation_controller.dart';
import '../controllers/reservations_controllers/cancel_reservation_controller.dart';
import '../widgets/BookingScreenWidgets.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({super.key});

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  final ShowReservationController showController = Get.put(
    ShowReservationController(),
  );
  final UpdateReservationController updateController = Get.put(
    UpdateReservationController(),
  );
  final CancelReservationController cancelController = Get.put(
    CancelReservationController(),
  );

  int selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _loadReservations();
  }

  Future<void> _loadReservations() async {
    await showController.loadReservations();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "36".tr,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Material(
                    elevation: selectedTab == 0 ? 2.0 : 50.0,
                    borderRadius: BorderRadius.circular(10),
                    child: BookingScreenWidgets(
                      wid: selectedTab == 0 ? 165.0 : 200.0,
                      path: "images/incoming.jpg",
                      tex: "38".tr,
                      onTap: () => setState(() => selectedTab = 0),
                    ),
                  ),
                ),
                const SizedBox(width: 20.0),
                Expanded(
                  child: Material(
                    elevation: selectedTab == 1 ? 2.0 : 50.0,
                    borderRadius: BorderRadius.circular(10),
                    child: BookingScreenWidgets(
                      wid: selectedTab == 1 ? 165.0 : 200.0,
                      path: "images/past.jpg",
                      tex: "37".tr,
                      onTap: () => setState(() => selectedTab = 1),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Expanded(
              child: Obx(() {
                if (showController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (showController.errorMessage.isNotEmpty) {
                  return Center(child: Text(showController.errorMessage.value));
                }

                final list = selectedTab == 0
                    ? showController.currentReservations
                    : showController.pastReservations;

                if (list.isEmpty) {
                  return Center(
                    child: Text(selectedTab == 0 ? "87".tr : "88".tr),
                  );
                }
                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (_, i) =>
                      _reservationTile(list[i], isPast: selectedTab == 1),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _reservationTile(Map<String, dynamic> r, {required bool isPast}) {
    final start = DateTime.tryParse(r["start_time"] ?? '') ?? DateTime.now();
    final end = DateTime.tryParse(r["end_time"] ?? '') ?? DateTime.now();

    final avgController = Get.put(ShowFlatAverageRatingController());
    final ratingController = Get.put(CreateFlatRatingController());

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text("Flat ID: ${r["flat_id"] ?? 'N/A'}"),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Price: ${r["price"] ?? 'N/A'} | Status: ${r["status"] ?? 'N/A'}\n"
              "From: ${start.toLocal().toString().split(' ')[0]} "
              "To: ${end.toLocal().toString().split(' ')[0]}",
            ),
            if (isPast)
              Obx(() {
                avgController.fetchAverageRating(flatId: r["flat_id"]);
                return Text(
                  "Average rating: ${avgController.averageRating.value.toStringAsFixed(1)}",
                  style: const TextStyle(color: Colors.black54),
                );
              }),
          ],
        ),
        trailing: isPast
            ? IconButton(
                icon: const Icon(Icons.star, color: Colors.amber),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      int tempRating = 3;
                      return AlertDialog(
                        title: const Text("Rate this flat"),
                        content: DropdownButton<int>(
                          value: tempRating,
                          items: List.generate(
                            5,
                            (i) => DropdownMenuItem(
                              value: i + 1,
                              child: Text("${i + 1} Stars"),
                            ),
                          ),
                          onChanged: (val) {
                            tempRating = val ?? 3;
                          },
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Cancel"),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              await ratingController.rateFlat(
                                flatId: r["flat_id"],
                                rating: tempRating,
                                token: "",
                              );
                              Navigator.pop(context);
                            },
                            child: const Text("Submit"),
                          ),
                        ],
                      );
                    },
                  );
                },
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.orange),
                    onPressed: () {
                      DateTime? newStart = DateTime.tryParse(
                        r["start_time"] ?? '',
                      );
                      DateTime? newEnd = DateTime.tryParse(r["end_time"] ?? '');

                      showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: const Text("Edit Reservation"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextButton(
                                  child: const Text("Pick new start date"),
                                  onPressed: () async {
                                    final picked = await showDatePicker(
                                      context: context,
                                      initialDate: newStart ?? DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2100),
                                    );
                                    if (picked != null) newStart = picked;
                                  },
                                ),
                                TextButton(
                                  child: const Text("Pick new end date"),
                                  onPressed: () async {
                                    final picked = await showDatePicker(
                                      context: context,
                                      initialDate: newEnd ?? DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2100),
                                    );
                                    if (picked != null) newEnd = picked;
                                  },
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Cancel"),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  if (newStart != null && newEnd != null) {
                                    await updateController.updateReservation(
                                      r["id"],
                                      newStart!.toIso8601String(),
                                      newEnd!.toIso8601String(),
                                    );
                                    Navigator.pop(context);
                                    await showController.loadReservations();
                                  }
                                },
                                child: const Text("Save"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.cancel, color: Colors.red),
                    onPressed: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text("Confirm Cancel"),
                          content: const Text(
                            "Do you really want to cancel this reservation?",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text("No"),
                            ),
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text("Yes"),
                            ),
                          ],
                        ),
                      );

                      if (confirm == true) {
                        await cancelController.cancelReservation(r["id"]);
                        await showController.loadReservations();
                      }
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
