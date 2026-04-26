// Layer: 02_MODELS_FOUNDATION
class FuseLoadingDto {
  final String id;
  final Map<String, dynamic> raw;

  FuseLoadingDto({required this.id, required this.raw});

  factory FuseLoadingDto.fromJson(Map<String, dynamic> json) {
    return FuseLoadingDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
