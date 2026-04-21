// Layer: 02_MODELS_FOUNDATION
class ClientDashboardMapperAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  ClientDashboardMapperAdapterDto({required this.id, required this.raw});

  factory ClientDashboardMapperAdapterDto.fromJson(Map<String, dynamic> json) {
    return ClientDashboardMapperAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
