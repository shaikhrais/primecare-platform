// Layer: 02_MODELS_FOUNDATION
class IntakeDashboardViewModelAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  IntakeDashboardViewModelAdapterDto({required this.id, required this.raw});

  factory IntakeDashboardViewModelAdapterDto.fromJson(Map<String, dynamic> json) {
    return IntakeDashboardViewModelAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
