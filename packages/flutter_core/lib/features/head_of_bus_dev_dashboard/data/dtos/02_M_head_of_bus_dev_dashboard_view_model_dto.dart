// Layer: 02_MODELS_FOUNDATION
class HeadOfBusDevDashboardViewModelDto {
  final String id;
  final Map<String, dynamic> raw;

  HeadOfBusDevDashboardViewModelDto({required this.id, required this.raw});

  factory HeadOfBusDevDashboardViewModelDto.fromJson(Map<String, dynamic> json) {
    return HeadOfBusDevDashboardViewModelDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

