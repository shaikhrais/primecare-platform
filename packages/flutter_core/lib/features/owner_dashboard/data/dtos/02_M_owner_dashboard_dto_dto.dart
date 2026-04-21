// Layer: 02_MODELS_FOUNDATION
class OwnerDashboardDtoDto {
  final String id;
  final Map<String, dynamic> raw;

  OwnerDashboardDtoDto({required this.id, required this.raw});

  factory OwnerDashboardDtoDto.fromJson(Map<String, dynamic> json) {
    return OwnerDashboardDtoDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

