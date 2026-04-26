// Layer: 02_MODELS_FOUNDATION
class ScheduleOpenHouseFormDto {
  final String id;
  final Map<String, dynamic> raw;

  ScheduleOpenHouseFormDto({required this.id, required this.raw});

  factory ScheduleOpenHouseFormDto.fromJson(Map<String, dynamic> json) {
    return ScheduleOpenHouseFormDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
