// Layer: 02_MODELS_FOUNDATION
class GreetingHeaderWidgetDto {
  final String id;
  final Map<String, dynamic> raw;

  GreetingHeaderWidgetDto({required this.id, required this.raw});

  factory GreetingHeaderWidgetDto.fromJson(Map<String, dynamic> json) {
    return GreetingHeaderWidgetDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

