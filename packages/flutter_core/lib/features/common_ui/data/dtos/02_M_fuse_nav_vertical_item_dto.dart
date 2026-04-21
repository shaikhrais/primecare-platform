// Layer: 02_MODELS_FOUNDATION
class FuseNavVerticalItemDto {
  final String id;
  final Map<String, dynamic> raw;

  FuseNavVerticalItemDto({required this.id, required this.raw});

  factory FuseNavVerticalItemDto.fromJson(Map<String, dynamic> json) {
    return FuseNavVerticalItemDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

