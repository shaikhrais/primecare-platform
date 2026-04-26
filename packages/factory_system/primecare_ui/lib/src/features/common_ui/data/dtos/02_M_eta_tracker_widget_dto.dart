// Layer: 02_MODELS_FOUNDATION
class EtaTrackerWidgetDto {
  final String id;
  final Map<String, dynamic> raw;

  EtaTrackerWidgetDto({required this.id, required this.raw});

  factory EtaTrackerWidgetDto.fromJson(Map<String, dynamic> json) {
    return EtaTrackerWidgetDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
