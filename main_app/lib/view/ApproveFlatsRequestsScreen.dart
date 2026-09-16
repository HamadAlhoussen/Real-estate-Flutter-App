import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/reservations_controllers/reservation_requests_controller.dart';
import '../../controllers/reservations_controllers/approve_reservation_controller.dart';
import '../../controllers/reservations_controllers/reject_reservation_controller.dart';
import '../../controllers/flats_controllers/show_flat_by_id_controller.dart';

class FlatsRequestsScreen extends StatefulWidget {
  const FlatsRequestsScreen({super.key});

  @override
  State<FlatsRequestsScreen> createState() => FlatsRequestsScreenState();
}

class FlatsRequestsScreenState extends State<FlatsRequestsScreen> {
  final bookingRequestsController = Get.put(BookingRequestsController());
  final approveController = Get.put(ApproveReservationController());
  final rejectController = Get.put(RejectReservationController());

  @override
  void initState() {
    super.initState();
    bookingRequestsController.loadRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Obx(() {
          if (bookingRequestsController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (bookingRequestsController.errorMessage.isNotEmpty) {
            return Center(
              child: Text(
                bookingRequestsController.errorMessage.value,
                style: const TextStyle(fontSize: 16),
              ),
            );
          }
          if (bookingRequestsController.requests.isEmpty) {
            return Center(
              child: Text("73".tr, style: const TextStyle(fontSize: 16)),
            );
          }

          return ListView.builder(
            itemCount: bookingRequestsController.requests.length,
            itemBuilder: (context, index) {
              final request = bookingRequestsController.requests[index];
              final flatController = Get.put(
                ShowFlatByIdController(),
                tag: "flat_${request.flatId}",
              );
              flatController.fetchFlatById(request.flatId);

              return Card(
                color: const Color.fromARGB(255, 255, 255, 255),
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.apartment, size: 30),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "Reservation #${request.id}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      Text(
                        "Start : ${request.startTime}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        "End : ${request.endTime}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        "Price : ${request.price}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Obx(() {
                        if (flatController.isLoading.value) {
                          return const Text("Loading flat details...");
                        }
                        if (flatController.errorMessage.isNotEmpty) {
                          return Text(
                            "Error: ${flatController.errorMessage.value}",
                          );
                        }
                        final flat = flatController.flat.value;
                        if (flat == null) {
                          return const Text("No flat details available");
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Governorate : ${flat.governorate}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              "City : ${flat.city}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              "Address : ${flat.address}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              "Section : ${flat.section}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        );
                      }),

                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                              onPressed: () async {
                                await approveController.approveReservation(
                                  request.id,
                                );
                                bookingRequestsController.requests.removeAt(
                                  index,
                                );
                                Get.snackbar("Success", "Reservation approved");
                              },
                              child: Text(
                                "57".tr,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              onPressed: () async {
                                await rejectController.rejectReservation(
                                  request.id,
                                );
                                bookingRequestsController.requests.removeAt(
                                  index,
                                );
                                Get.snackbar("Success", "Reservation rejected");
                              },
                              child: Text(
                                "58".tr,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
