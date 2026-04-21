// Layer: 02_MODELS_FOUNDATION
class CustomerSupportDashboardAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  CustomerSupportDashboardAdapterDto({required this.id, required this.raw});

  factory CustomerSupportDashboardAdapterDto.fromJson(Map<String, dynamic> json) {
    return CustomerSupportDashboardAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
