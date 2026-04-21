// Layer: 02_MODELS_FOUNDATION
class PartnershipManagerDashboardAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  PartnershipManagerDashboardAdapterDto({required this.id, required this.raw});

  factory PartnershipManagerDashboardAdapterDto.fromJson(Map<String, dynamic> json) {
    return PartnershipManagerDashboardAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
