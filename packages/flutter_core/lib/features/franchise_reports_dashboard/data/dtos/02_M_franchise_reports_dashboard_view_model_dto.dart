// Layer: 02_MODELS_FOUNDATION
class FranchiseReportsDashboardViewModelDto {
  final String id;
  final Map<String, dynamic> raw;

  FranchiseReportsDashboardViewModelDto({required this.id, required this.raw});

  factory FranchiseReportsDashboardViewModelDto.fromJson(Map<String, dynamic> json) {
    return FranchiseReportsDashboardViewModelDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

