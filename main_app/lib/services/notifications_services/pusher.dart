import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class PusherService {
  late PusherChannelsFlutter _pusher;

  Future<void> initPusher() async {
    _pusher = PusherChannelsFlutter.getInstance();

    await _pusher.init(
      apiKey: "YOUR_PUSHER_KEY",
      cluster: "YOUR_CLUSTER",
      logToConsole: true,
      useTLS: true,
      onConnectionStateChange: (String previousState, String currentState) {
        print("Connection state changed: $previousState → $currentState");
      },
      onError: (message, code, e) {
        print("Error: $message");
      },
      onEvent: (event) {
        print("Event received: ${event.data}");
      },
    );

    await _pusher.connect();

    await _pusher.subscribe(channelName: "notifications");
  }
}
