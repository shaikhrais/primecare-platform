// Layer: 02_MODELS_FOUNDATION
class AppDto {
  final String id;
  final Map<String, dynamic> raw;

  AppDto({required this.id, required this.raw});

  factory AppDto.fromJson(Map<String, dynamic> json) {
    return AppDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

