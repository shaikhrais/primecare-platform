// Layer: 02_MODELS_FOUNDATION
class AdminDashboardDtoDto {
  final String id;
  final Map<String, dynamic> raw;

  AdminDashboardDtoDto({required this.id, required this.raw});

  factory AdminDashboardDtoDto.fromJson(Map<String, dynamic> json) {
    return AdminDashboardDtoDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

