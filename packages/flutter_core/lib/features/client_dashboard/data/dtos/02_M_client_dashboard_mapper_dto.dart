// Layer: 02_MODELS_FOUNDATION
class ClientDashboardMapperDto {
  final String id;
  final Map<String, dynamic> raw;

  ClientDashboardMapperDto({required this.id, required this.raw});

  factory ClientDashboardMapperDto.fromJson(Map<String, dynamic> json) {
    return ClientDashboardMapperDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

