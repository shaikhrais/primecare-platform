// Layer: 02_MODELS_FOUNDATION
class IntakeDashboardViewModelDto {
  final String id;
  final Map<String, dynamic> raw;

  IntakeDashboardViewModelDto({required this.id, required this.raw});

  factory IntakeDashboardViewModelDto.fromJson(Map<String, dynamic> json) {
    return IntakeDashboardViewModelDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

