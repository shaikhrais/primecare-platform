// Layer: 02_MODELS_FOUNDATION
class FuseNavVerticalTabDto {
  final String id;
  final Map<String, dynamic> raw;

  FuseNavVerticalTabDto({required this.id, required this.raw});

  factory FuseNavVerticalTabDto.fromJson(Map<String, dynamic> json) {
    return FuseNavVerticalTabDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

