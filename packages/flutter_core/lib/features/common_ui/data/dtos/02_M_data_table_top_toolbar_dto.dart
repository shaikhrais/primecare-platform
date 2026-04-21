// Layer: 02_MODELS_FOUNDATION
class DataTableTopToolbarDto {
  final String id;
  final Map<String, dynamic> raw;

  DataTableTopToolbarDto({required this.id, required this.raw});

  factory DataTableTopToolbarDto.fromJson(Map<String, dynamic> json) {
    return DataTableTopToolbarDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

