DateTime _parseBirthDate(String? dateStr) {
  if (dateStr == null || dateStr.isEmpty) {
    return DateTime(2000, 1, 1);
  }
  try {
    final normalized = dateStr.replaceAll('/', '-');
    return DateTime.parse(normalized);
  } catch (_) {
    return DateTime(2000, 1, 1);
  }
}

class UserAccountModel {
  final int id;
  final String firstName;
  final String lastName;
  final String phone;
  final String avatarPath;
  final String idCardPath;
  final DateTime birthDate;

  UserAccountModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.avatarPath,
    required this.idCardPath,
    required this.birthDate,
  });

  factory UserAccountModel.fromJson(Map<String, dynamic> json) {
    return UserAccountModel(
      id: json['id'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      phone: json['phone'] ?? '',
      avatarPath:
          //  json['profile(avatar)_picture_path'] ??
          json['avatar_path'] ?? '',
      idCardPath: json['id_card_picture_path'] ?? json['id_card_path'] ?? '',
      birthDate: _parseBirthDate(json['birth_date']),
    );
  }
}
