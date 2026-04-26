// Layer: 02_MODELS_FOUNDATION
class MoodSliderWidgetDto {
  final String id;
  final Map<String, dynamic> raw;

  MoodSliderWidgetDto({required this.id, required this.raw});

  factory MoodSliderWidgetDto.fromJson(Map<String, dynamic> json) {
    return MoodSliderWidgetDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
