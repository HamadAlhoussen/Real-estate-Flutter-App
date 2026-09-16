class FlatModel {
  final int id;
  final String governorate;
  final String city;
  final double price;
  final int rooms;
  final int space;
  final int floor;
  final bool hasElevator;
  final bool isFurnished;
  final int userId;
  final String? flatImage;
  final String? address;
  final String? status;
  final String? section;
  final String? availableDate;

  FlatModel({
    required this.id,
    required this.governorate,
    required this.city,
    required this.price,
    required this.rooms,
    required this.space,
    required this.floor,
    required this.hasElevator,
    required this.isFurnished,
    required this.userId,
    this.flatImage,
    this.address,
    this.status,
    this.section,
    this.availableDate,
  });

  factory FlatModel.fromJson(Map<String, dynamic> json) {
    return FlatModel(
      id: json['id'] ?? 0,
      governorate: json['governorate'] ?? '',
      city: json['city'] ?? '',
      price: double.tryParse(json['price']?.toString() ?? '0') ?? 0,
      rooms: int.tryParse(json['rooms']?.toString() ?? '0') ?? 0,
      space: int.tryParse(json['space']?.toString() ?? '0') ?? 0,
      floor: int.tryParse(json['floor']?.toString() ?? '0') ?? 0,
      hasElevator: json['has_elevator'] == 1,
      isFurnished: json['is_furnished'] == 1,
      userId: json['user_id'] ?? 0,
      flatImage: json['flat_image'],
      address: json['address'],
      status: json['status'],
      section: json['section'],
      availableDate: json['available_date'],
    );
  }
}
