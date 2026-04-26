// Layer: 02_MODELS_FOUNDATION
class FuseNavVerticalItemBaseDto {
  final String id;
  final Map<String, dynamic> raw;

  FuseNavVerticalItemBaseDto({required this.id, required this.raw});

  factory FuseNavVerticalItemBaseDto.fromJson(Map<String, dynamic> json) {
    return FuseNavVerticalItemBaseDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
