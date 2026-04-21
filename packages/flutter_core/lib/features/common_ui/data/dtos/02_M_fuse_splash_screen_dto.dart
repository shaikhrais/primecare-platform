// Layer: 02_MODELS_FOUNDATION
class FuseSplashScreenDto {
  final String id;
  final Map<String, dynamic> raw;

  FuseSplashScreenDto({required this.id, required this.raw});

  factory FuseSplashScreenDto.fromJson(Map<String, dynamic> json) {
    return FuseSplashScreenDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

