// Layer: 02_MODELS_FOUNDATION
class GeneralManagerDashboardViewModelDto {
  final String id;
  final Map<String, dynamic> raw;

  GeneralManagerDashboardViewModelDto({required this.id, required this.raw});

  factory GeneralManagerDashboardViewModelDto.fromJson(Map<String, dynamic> json) {
    return GeneralManagerDashboardViewModelDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

