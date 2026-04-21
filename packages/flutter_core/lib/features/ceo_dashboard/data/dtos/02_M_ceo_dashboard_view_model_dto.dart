// Layer: 02_MODELS_FOUNDATION
class CeoDashboardViewModelDto {
  final String id;
  final Map<String, dynamic> raw;

  CeoDashboardViewModelDto({required this.id, required this.raw});

  factory CeoDashboardViewModelDto.fromJson(Map<String, dynamic> json) {
    return CeoDashboardViewModelDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

