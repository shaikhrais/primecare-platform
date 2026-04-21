// Layer: 02_MODELS_FOUNDATION
class FuseHighlightDto {
  final String id;
  final Map<String, dynamic> raw;

  FuseHighlightDto({required this.id, required this.raw});

  factory FuseHighlightDto.fromJson(Map<String, dynamic> json) {
    return FuseHighlightDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

