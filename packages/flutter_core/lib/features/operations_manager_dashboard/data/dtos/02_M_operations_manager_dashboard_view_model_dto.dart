// Layer: 02_MODELS_FOUNDATION
class OperationsManagerDashboardViewModelDto {
  final String id;
  final Map<String, dynamic> raw;

  OperationsManagerDashboardViewModelDto({required this.id, required this.raw});

  factory OperationsManagerDashboardViewModelDto.fromJson(Map<String, dynamic> json) {
    return OperationsManagerDashboardViewModelDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

