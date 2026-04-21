// Layer: 02_MODELS_FOUNDATION
class HeadOfMarketingDashboardViewModelDto {
  final String id;
  final Map<String, dynamic> raw;

  HeadOfMarketingDashboardViewModelDto({required this.id, required this.raw});

  factory HeadOfMarketingDashboardViewModelDto.fromJson(Map<String, dynamic> json) {
    return HeadOfMarketingDashboardViewModelDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

