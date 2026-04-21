// Layer: 02_MODELS_FOUNDATION
class ClientDashboardAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  ClientDashboardAdapterDto({required this.id, required this.raw});

  factory ClientDashboardAdapterDto.fromJson(Map<String, dynamic> json) {
    return ClientDashboardAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
