// Layer: 02_MODELS_FOUNDATION
class FuseNavBadgeDto {
  final String id;
  final Map<String, dynamic> raw;

  FuseNavBadgeDto({required this.id, required this.raw});

  factory FuseNavBadgeDto.fromJson(Map<String, dynamic> json) {
    return FuseNavBadgeDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

