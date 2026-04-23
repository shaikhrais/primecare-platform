// Layer: 02_MODELS_FOUNDATION
class ExampleViewDto {
  final String id;
  final Map<String, dynamic> raw;

  ExampleViewDto({required this.id, required this.raw});

  factory ExampleViewDto.fromJson(Map<String, dynamic> json) {
    return ExampleViewDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

