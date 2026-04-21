// Layer: 02_MODELS_FOUNDATION
class CooDashboardViewModelDto {
  final String id;
  final Map<String, dynamic> raw;

  CooDashboardViewModelDto({required this.id, required this.raw});

  factory CooDashboardViewModelDto.fromJson(Map<String, dynamic> json) {
    return CooDashboardViewModelDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

