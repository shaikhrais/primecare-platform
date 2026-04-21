// Layer: 02_MODELS_FOUNDATION
class OperationsManagerDashboardDtoDto {
  final String id;
  final Map<String, dynamic> raw;

  OperationsManagerDashboardDtoDto({required this.id, required this.raw});

  factory OperationsManagerDashboardDtoDto.fromJson(Map<String, dynamic> json) {
    return OperationsManagerDashboardDtoDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

