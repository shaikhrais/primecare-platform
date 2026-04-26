// Layer: 02_MODELS_FOUNDATION
class FuseNavVerticalLinkDto {
  final String id;
  final Map<String, dynamic> raw;

  FuseNavVerticalLinkDto({required this.id, required this.raw});

  factory FuseNavVerticalLinkDto.fromJson(Map<String, dynamic> json) {
    return FuseNavVerticalLinkDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
