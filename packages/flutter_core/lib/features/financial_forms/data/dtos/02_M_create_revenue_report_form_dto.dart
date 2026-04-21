// Layer: 02_MODELS_FOUNDATION
class CreateRevenueReportFormDto {
  final String id;
  final Map<String, dynamic> raw;

  CreateRevenueReportFormDto({required this.id, required this.raw});

  factory CreateRevenueReportFormDto.fromJson(Map<String, dynamic> json) {
    return CreateRevenueReportFormDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

