// Layer: 02_MODELS_FOUNDATION
class FuseNavHorizontalCollapseDto {
  final String id;
  final Map<String, dynamic> raw;

  FuseNavHorizontalCollapseDto({required this.id, required this.raw});

  factory FuseNavHorizontalCollapseDto.fromJson(Map<String, dynamic> json) {
    return FuseNavHorizontalCollapseDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
