// Layer: 02_MODELS_FOUNDATION
class FranchiseReportsDashboardDtoDto {
  final String id;
  final Map<String, dynamic> raw;

  FranchiseReportsDashboardDtoDto({required this.id, required this.raw});

  factory FranchiseReportsDashboardDtoDto.fromJson(Map<String, dynamic> json) {
    return FranchiseReportsDashboardDtoDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

