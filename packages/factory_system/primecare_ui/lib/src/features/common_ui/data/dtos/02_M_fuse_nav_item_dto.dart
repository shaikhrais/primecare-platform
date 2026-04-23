// Layer: 02_MODELS_FOUNDATION
class FuseNavItemDto {
  final String id;
  final Map<String, dynamic> raw;

  FuseNavItemDto({required this.id, required this.raw});

  factory FuseNavItemDto.fromJson(Map<String, dynamic> json) {
    return FuseNavItemDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

