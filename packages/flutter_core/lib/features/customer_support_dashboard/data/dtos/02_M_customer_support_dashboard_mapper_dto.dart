// Layer: 02_MODELS_FOUNDATION
class CustomerSupportDashboardMapperDto {
  final String id;
  final Map<String, dynamic> raw;

  CustomerSupportDashboardMapperDto({required this.id, required this.raw});

  factory CustomerSupportDashboardMapperDto.fromJson(Map<String, dynamic> json) {
    return CustomerSupportDashboardMapperDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

