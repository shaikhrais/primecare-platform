// Layer: 02_MODELS_FOUNDATION
class DataTableDto {
  final String id;
  final Map<String, dynamic> raw;

  DataTableDto({required this.id, required this.raw});

  factory DataTableDto.fromJson(Map<String, dynamic> json) {
    return DataTableDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
