// Layer: 02_MODELS_FOUNDATION
class FamilyDashboardDtoDto {
  final String id;
  final Map<String, dynamic> raw;

  FamilyDashboardDtoDto({required this.id, required this.raw});

  factory FamilyDashboardDtoDto.fromJson(Map<String, dynamic> json) {
    return FamilyDashboardDtoDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

