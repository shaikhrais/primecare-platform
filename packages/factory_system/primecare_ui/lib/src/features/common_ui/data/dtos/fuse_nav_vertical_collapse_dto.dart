// Layer: 02_MODELS_FOUNDATION
class FuseNavVerticalCollapseDto {
  final String id;
  final Map<String, dynamic> raw;

  FuseNavVerticalCollapseDto({required this.id, required this.raw});

  factory FuseNavVerticalCollapseDto.fromJson(Map<String, dynamic> json) {
    return FuseNavVerticalCollapseDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
