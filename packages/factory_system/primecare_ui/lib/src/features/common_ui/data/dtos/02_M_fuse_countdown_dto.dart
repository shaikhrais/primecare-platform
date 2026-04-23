// Layer: 02_MODELS_FOUNDATION
class FuseCountdownDto {
  final String id;
  final Map<String, dynamic> raw;

  FuseCountdownDto({required this.id, required this.raw});

  factory FuseCountdownDto.fromJson(Map<String, dynamic> json) {
    return FuseCountdownDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

