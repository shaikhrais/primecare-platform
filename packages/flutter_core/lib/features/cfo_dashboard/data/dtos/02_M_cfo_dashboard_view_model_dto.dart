// Layer: 02_MODELS_FOUNDATION
class CfoDashboardViewModelDto {
  final String id;
  final Map<String, dynamic> raw;

  CfoDashboardViewModelDto({required this.id, required this.raw});

  factory CfoDashboardViewModelDto.fromJson(Map<String, dynamic> json) {
    return CfoDashboardViewModelDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

