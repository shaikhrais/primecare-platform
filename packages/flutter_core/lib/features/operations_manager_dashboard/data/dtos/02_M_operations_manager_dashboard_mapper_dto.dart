// Layer: 02_MODELS_FOUNDATION
class OperationsManagerDashboardMapperDto {
  final String id;
  final Map<String, dynamic> raw;

  OperationsManagerDashboardMapperDto({required this.id, required this.raw});

  factory OperationsManagerDashboardMapperDto.fromJson(Map<String, dynamic> json) {
    return OperationsManagerDashboardMapperDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

