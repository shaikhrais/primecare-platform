// Layer: 02_MODELS_FOUNDATION
class FamilyDashboardMapperDto {
  final String id;
  final Map<String, dynamic> raw;

  FamilyDashboardMapperDto({required this.id, required this.raw});

  factory FamilyDashboardMapperDto.fromJson(Map<String, dynamic> json) {
    return FamilyDashboardMapperDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

