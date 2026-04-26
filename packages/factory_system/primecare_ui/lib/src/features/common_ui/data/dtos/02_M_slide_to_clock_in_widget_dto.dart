// Layer: 02_MODELS_FOUNDATION
class SlideToClockInWidgetDto {
  final String id;
  final Map<String, dynamic> raw;

  SlideToClockInWidgetDto({required this.id, required this.raw});

  factory SlideToClockInWidgetDto.fromJson(Map<String, dynamic> json) {
    return SlideToClockInWidgetDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
