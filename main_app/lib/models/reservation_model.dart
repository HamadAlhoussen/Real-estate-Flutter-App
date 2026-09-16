class ReservationModel {
  final int id;
  final int flatId;
  final DateTime startTime;
  final DateTime endTime;
  final double price;
  final String status;

  ReservationModel({
    required this.id,
    required this.flatId,
    required this.startTime,
    required this.endTime,
    required this.price,
    required this.status,
  });

  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    return ReservationModel(
      id: json['id'],
      flatId: json['flat_id'],
      startTime: DateTime.parse(json['start_time']),
      endTime: DateTime.parse(json['end_time']),
      price: double.parse(json['price'].toString()),
      status: json['status'],
    );
  }
}
