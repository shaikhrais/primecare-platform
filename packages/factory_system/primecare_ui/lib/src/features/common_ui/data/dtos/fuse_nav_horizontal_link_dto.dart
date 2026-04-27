// Layer: 02_MODELS_FOUNDATION
class FuseNavHorizontalLinkDto {
  final String id;
  final Map<String, dynamic> raw;

  FuseNavHorizontalLinkDto({required this.id, required this.raw});

  factory FuseNavHorizontalLinkDto.fromJson(Map<String, dynamic> json) {
    return FuseNavHorizontalLinkDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
