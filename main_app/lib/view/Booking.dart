import '../models/flat_model.dart';

class Booking {
  String id;
  String userId;
  DateTime from;
  DateTime to;
  FlatModel flat;

  Booking({
    required this.id,
    required this.userId,
    required this.from,
    required this.to,
    required this.flat,
  });
}
