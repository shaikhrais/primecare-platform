// Layer: 02_MODELS_FOUNDATION
class FuseNavigationDto {
  final String id;
  final Map<String, dynamic> raw;

  FuseNavigationDto({required this.id, required this.raw});

  factory FuseNavigationDto.fromJson(Map<String, dynamic> json) {
    return FuseNavigationDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

