// Layer: 02_MODELS_FOUNDATION
class DynamicRoleDashboardScreenDto {
  final String id;
  final Map<String, dynamic> raw;

  DynamicRoleDashboardScreenDto({required this.id, required this.raw});

  factory DynamicRoleDashboardScreenDto.fromJson(Map<String, dynamic> json) {
    return DynamicRoleDashboardScreenDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

