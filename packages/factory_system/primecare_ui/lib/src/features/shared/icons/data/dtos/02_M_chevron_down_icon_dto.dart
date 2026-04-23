// Layer: 02_MODELS_FOUNDATION
class ChevronDownIconDto {
  final String id;
  final Map<String, dynamic> raw;

  ChevronDownIconDto({required this.id, required this.raw});

  factory ChevronDownIconDto.fromJson(Map<String, dynamic> json) {
    return ChevronDownIconDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

