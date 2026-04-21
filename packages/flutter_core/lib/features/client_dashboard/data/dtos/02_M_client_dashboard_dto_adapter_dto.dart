// Layer: 02_MODELS_FOUNDATION
class ClientDashboardDtoAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  ClientDashboardDtoAdapterDto({required this.id, required this.raw});

  factory ClientDashboardDtoAdapterDto.fromJson(Map<String, dynamic> json) {
    return ClientDashboardDtoAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
