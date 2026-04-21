// Layer: 02_MODELS_FOUNDATION
class DemoDashboardViewModelAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  DemoDashboardViewModelAdapterDto({required this.id, required this.raw});

  factory DemoDashboardViewModelAdapterDto.fromJson(Map<String, dynamic> json) {
    return DemoDashboardViewModelAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
