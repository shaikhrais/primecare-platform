// Layer: 02_MODELS_FOUNDATION
class DemoLayoutFooterContentDto {
  final String id;
  final Map<String, dynamic> raw;

  DemoLayoutFooterContentDto({required this.id, required this.raw});

  factory DemoLayoutFooterContentDto.fromJson(Map<String, dynamic> json) {
    return DemoLayoutFooterContentDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
