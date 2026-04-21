// Layer: 02_MODELS_FOUNDATION
class CtoDashboardViewModelDto {
  final String id;
  final Map<String, dynamic> raw;

  CtoDashboardViewModelDto({required this.id, required this.raw});

  factory CtoDashboardViewModelDto.fromJson(Map<String, dynamic> json) {
    return CtoDashboardViewModelDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

