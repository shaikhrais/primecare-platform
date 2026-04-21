// Layer: 02_MODELS_FOUNDATION
class SplashScreenDto {
  final String id;
  final Map<String, dynamic> raw;

  SplashScreenDto({required this.id, required this.raw});

  factory SplashScreenDto.fromJson(Map<String, dynamic> json) {
    return SplashScreenDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

