// Layer: 02_MODELS_FOUNDATION
class AdminDashboardMapperDto {
  final String id;
  final Map<String, dynamic> raw;

  AdminDashboardMapperDto({required this.id, required this.raw});

  factory AdminDashboardMapperDto.fromJson(Map<String, dynamic> json) {
    return AdminDashboardMapperDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

