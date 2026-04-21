// Layer: 02_MODELS_FOUNDATION
class DemoDashboardViewModelDto {
  final String id;
  final Map<String, dynamic> raw;

  DemoDashboardViewModelDto({required this.id, required this.raw});

  factory DemoDashboardViewModelDto.fromJson(Map<String, dynamic> json) {
    return DemoDashboardViewModelDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

