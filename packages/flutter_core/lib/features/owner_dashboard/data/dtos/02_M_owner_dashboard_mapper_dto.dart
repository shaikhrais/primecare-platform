// Layer: 02_MODELS_FOUNDATION
class OwnerDashboardMapperDto {
  final String id;
  final Map<String, dynamic> raw;

  OwnerDashboardMapperDto({required this.id, required this.raw});

  factory OwnerDashboardMapperDto.fromJson(Map<String, dynamic> json) {
    return OwnerDashboardMapperDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

