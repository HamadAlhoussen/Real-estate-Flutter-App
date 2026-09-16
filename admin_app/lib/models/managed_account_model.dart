DateTime _parseBirthDate(String? dateStr) {
  if (dateStr == null || dateStr.isEmpty) {
    return DateTime(2000, 1, 1);
  }
  try {
    // Normalize separators before parsing
    final normalized = dateStr.replaceAll('/', '-');
    return DateTime.parse(normalized);
  } catch (_) {
    // Fallback if parsing fails
    return DateTime(2000, 1, 1);
  }
}

class ManagedAccountModel {
  final int id;
  final String firstName;
  final String lastName;
  final String phone;
  final String avatarPath;
  final String idCardPath;
  final DateTime birthDate;
  final String status;

  ManagedAccountModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.avatarPath,
    required this.idCardPath,
    required this.birthDate,
    required this.status,
  });

  /// Factory constructor to build from JSON
  factory ManagedAccountModel.fromJson(Map<String, dynamic> json) {
    return ManagedAccountModel(
      id: json['id'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      phone: json['phone'] ?? '',
      avatarPath:
          json['profile(avatar)_picture_path'] ?? json['avatar_path'] ?? '',
      idCardPath: json['id_card_picture_path'] ?? json['id_card_path'] ?? '',
      birthDate: _parseBirthDate(json['birth_date']),
      status: json['status'] ?? '',
    );
  }

  /// Convert back to JSON (optional but useful)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'avatar_path': avatarPath,
      'id_card_path': idCardPath,
      'birth_date': birthDate.toIso8601String(),
      'status': status,
    };
  }

  /// CopyWith for easy updates (e.g. change status only)
  ManagedAccountModel copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? phone,
    String? avatarPath,
    String? idCardPath,
    DateTime? birthDate,
    String? status,
  }) {
    return ManagedAccountModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      avatarPath: avatarPath ?? this.avatarPath,
      idCardPath: idCardPath ?? this.idCardPath,
      birthDate: birthDate ?? this.birthDate,
      status: status ?? this.status,
    );
  }
}
