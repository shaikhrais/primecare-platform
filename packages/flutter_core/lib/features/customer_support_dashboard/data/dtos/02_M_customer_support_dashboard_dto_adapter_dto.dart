// Layer: 02_MODELS_FOUNDATION
class CustomerSupportDashboardDtoAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  CustomerSupportDashboardDtoAdapterDto({required this.id, required this.raw});

  factory CustomerSupportDashboardDtoAdapterDto.fromJson(Map<String, dynamic> json) {
    return CustomerSupportDashboardDtoAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
