// Layer: 02_MODELS_FOUNDATION
class AdminLayoutDto {
  final String id;
  final Map<String, dynamic> raw;

  AdminLayoutDto({required this.id, required this.raw});

  factory AdminLayoutDto.fromJson(Map<String, dynamic> json) {
    return AdminLayoutDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

