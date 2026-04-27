// Layer: 02_MODELS_FOUNDATION
class FuseNavHorizontalItemDto {
  final String id;
  final Map<String, dynamic> raw;

  FuseNavHorizontalItemDto({required this.id, required this.raw});

  factory FuseNavHorizontalItemDto.fromJson(Map<String, dynamic> json) {
    return FuseNavHorizontalItemDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
