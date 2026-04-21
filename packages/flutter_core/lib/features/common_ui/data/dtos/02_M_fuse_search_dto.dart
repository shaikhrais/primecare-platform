// Layer: 02_MODELS_FOUNDATION
class FuseSearchDto {
  final String id;
  final Map<String, dynamic> raw;

  FuseSearchDto({required this.id, required this.raw});

  factory FuseSearchDto.fromJson(Map<String, dynamic> json) {
    return FuseSearchDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

