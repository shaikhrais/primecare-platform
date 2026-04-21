// Layer: 02_MODELS_FOUNDATION
class DemoFrameDto {
  final String id;
  final Map<String, dynamic> raw;

  DemoFrameDto({required this.id, required this.raw});

  factory DemoFrameDto.fromJson(Map<String, dynamic> json) {
    return DemoFrameDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

