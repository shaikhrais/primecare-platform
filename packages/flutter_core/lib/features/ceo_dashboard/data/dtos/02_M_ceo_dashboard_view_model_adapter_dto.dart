// Layer: 02_MODELS_FOUNDATION
class CeoDashboardViewModelAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  CeoDashboardViewModelAdapterDto({required this.id, required this.raw});

  factory CeoDashboardViewModelAdapterDto.fromJson(Map<String, dynamic> json) {
    return CeoDashboardViewModelAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
