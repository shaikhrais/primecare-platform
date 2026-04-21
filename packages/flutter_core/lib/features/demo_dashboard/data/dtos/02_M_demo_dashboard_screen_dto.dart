// Layer: 02_MODELS_FOUNDATION
class DemoDashboardScreenDto {
  final String id;
  final Map<String, dynamic> raw;

  DemoDashboardScreenDto({required this.id, required this.raw});

  factory DemoDashboardScreenDto.fromJson(Map<String, dynamic> json) {
    return DemoDashboardScreenDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

