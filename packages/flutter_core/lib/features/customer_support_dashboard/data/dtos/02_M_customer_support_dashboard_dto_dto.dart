// Layer: 02_MODELS_FOUNDATION
class CustomerSupportDashboardDtoDto {
  final String id;
  final Map<String, dynamic> raw;

  CustomerSupportDashboardDtoDto({required this.id, required this.raw});

  factory CustomerSupportDashboardDtoDto.fromJson(Map<String, dynamic> json) {
    return CustomerSupportDashboardDtoDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

