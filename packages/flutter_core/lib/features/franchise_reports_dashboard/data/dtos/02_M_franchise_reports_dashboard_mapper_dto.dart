// Layer: 02_MODELS_FOUNDATION
class FranchiseReportsDashboardMapperDto {
  final String id;
  final Map<String, dynamic> raw;

  FranchiseReportsDashboardMapperDto({required this.id, required this.raw});

  factory FranchiseReportsDashboardMapperDto.fromJson(Map<String, dynamic> json) {
    return FranchiseReportsDashboardMapperDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

