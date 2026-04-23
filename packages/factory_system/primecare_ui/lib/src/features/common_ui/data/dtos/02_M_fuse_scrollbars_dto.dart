// Layer: 02_MODELS_FOUNDATION
class FuseScrollbarsDto {
  final String id;
  final Map<String, dynamic> raw;

  FuseScrollbarsDto({required this.id, required this.raw});

  factory FuseScrollbarsDto.fromJson(Map<String, dynamic> json) {
    return FuseScrollbarsDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

