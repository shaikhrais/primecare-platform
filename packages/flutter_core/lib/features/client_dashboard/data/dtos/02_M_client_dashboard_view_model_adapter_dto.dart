// Layer: 02_MODELS_FOUNDATION
class ClientDashboardViewModelAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  ClientDashboardViewModelAdapterDto({required this.id, required this.raw});

  factory ClientDashboardViewModelAdapterDto.fromJson(Map<String, dynamic> json) {
    return ClientDashboardViewModelAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
