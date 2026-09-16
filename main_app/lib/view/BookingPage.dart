import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/flat_model.dart';
import 'Booking.dart';
import '../../controllers/reservations_controllers/create_reservation_controller.dart';
import '../../utils/app_preferances.dart';

class BookingPage extends StatefulWidget {
  final FlatModel flat;
  final List<Booking> bookings;
  final Function(Booking) onBooked;

  const BookingPage({
    super.key,
    required this.flat,
    required this.bookings,
    required this.onBooked,
  });

  @override
  State<BookingPage> createState() => BookingPageState();
}

class BookingPageState extends State<BookingPage> {
  DateTime? fromDate;
  DateTime? toDate;

  final _controller = Get.put(CreateReservationController());

  bool isAvailable(DateTime start, DateTime end) {
    return !widget.bookings.any(
      (b) =>
          b.flat.id == widget.flat.id &&
          !(end.isBefore(b.from) || start.isAfter(b.to)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              if (Get.locale?.languageCode == 'en') ...[
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ] else ...[
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
              Card(
                color: const Color.fromRGBO(196, 224, 248, 1),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.flat.governorate}, ${widget.flat.city}",
                        style: const TextStyle(
                          color: Color.fromRGBO(6, 17, 53, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 1,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Wrap(
                            children: [
                              Text(
                                "21".tr,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                " : ${widget.flat.rooms}",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
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
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "31".tr,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 5),
                          Wrap(
                            children: [
                              Text(
                                "25".tr,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                " : ${widget.flat.floor}",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        "${widget.flat.price}\$",
                        style: const TextStyle(
                          color: Color.fromRGBO(6, 17, 53, 1),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
                              size: 35,
                            ),
                            const SizedBox(width: 10),
                            Icon(
                              Icons.home,
                              color: widget.flat.isFurnished
                                  ? const Color.fromRGBO(6, 17, 53, 1)
                                  : Colors.grey,
                              size: 35,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
              ListTile(
                title: Text("51".tr),
                subtitle: Text(
                  fromDate != null
                      ? fromDate!.toLocal().toString().split(' ')[0]
                      : "53".tr,
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (picked != null) setState(() => fromDate = picked);
                },
              ),
              ListTile(
                title: Text("52".tr),
                subtitle: Text(
                  toDate != null
                      ? toDate!.toLocal().toString().split(' ')[0]
                      : "54".tr,
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: fromDate ?? DateTime.now(),
                    firstDate: fromDate ?? DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (picked != null) setState(() => toDate = picked);
                },
              ),

              const SizedBox(height: 20),
              Obx(() {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(6, 17, 53, 1),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: _controller.isLoading.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text("50".tr, style: const TextStyle(fontSize: 20)),
                      onPressed: () async {
                        if (fromDate == null || toDate == null) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text("55".tr)));
                          return;
                        }

                        if (!isAvailable(fromDate!, toDate!)) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text("74".tr)));
                          return;
                        }

                        final token = await AppPreferences.getToken() ?? '';

                        await _controller.createReservation(
                          token,
                          fromDate!.toIso8601String(),
                          toDate!.toIso8601String(),
                          widget.flat.id,
                          widget.flat.price,
                        );

                        if (_controller.errorMessage.value.isNotEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(_controller.errorMessage.value),
                            ),
                          );
                        } else {
                          final booking = Booking(
                            id: DateTime.now().millisecondsSinceEpoch
                                .toString(),
                            userId: "user1",
                            from: fromDate!,
                            to: toDate!,
                            flat: widget.flat,
                          );

                          widget.bookings.add(booking);
                          widget.onBooked(booking);

                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text("56".tr)));
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
