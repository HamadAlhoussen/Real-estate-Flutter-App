import 'package:get/get.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../reservations_controllers/show_reservations_controller.dart';

class PusherController extends GetxController {
  late PusherChannelsFlutter pusher;

  @override
  void onInit() {
    super.onInit();
    initPusher();
  }

  Future<void> initPusher() async {
    pusher = PusherChannelsFlutter.getInstance();

    await pusher.init(
      apiKey: "YOUR_PUSHER_KEY",
      cluster: "YOUR_CLUSTER",
      useTLS: true,
      logToConsole: true,

      onConnectionStateChange: (String prev, String current) {
        print("Pusher: $prev → $current");
      },

      onError: (String message, int? code, dynamic e) {
        print("Pusher Error: $message");
      },

      onEvent: (event) {
        print("EVENT RECEIVED: ${event.data}");

        Get.snackbar("Notification", event.data.toString());

        if (event.eventName == "reservation-updated") {
          Get.find<ShowReservationController>().loadReservations();
        }
      },
    );

    await pusher.connect();
    await pusher.subscribe(channelName: "notifications");
  }
}
