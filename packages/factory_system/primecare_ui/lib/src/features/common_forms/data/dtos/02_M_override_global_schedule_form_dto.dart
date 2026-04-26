// Layer: 02_MODELS_FOUNDATION
class OverrideGlobalScheduleFormDto {
  final String id;
  final Map<String, dynamic> raw;

  OverrideGlobalScheduleFormDto({required this.id, required this.raw});

  factory OverrideGlobalScheduleFormDto.fromJson(Map<String, dynamic> json) {
    return OverrideGlobalScheduleFormDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
