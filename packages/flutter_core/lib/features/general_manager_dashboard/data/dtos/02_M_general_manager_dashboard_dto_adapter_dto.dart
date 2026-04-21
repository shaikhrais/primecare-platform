// Layer: 02_MODELS_FOUNDATION
class GeneralManagerDashboardDtoAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  GeneralManagerDashboardDtoAdapterDto({required this.id, required this.raw});

  factory GeneralManagerDashboardDtoAdapterDto.fromJson(Map<String, dynamic> json) {
    return GeneralManagerDashboardDtoAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
