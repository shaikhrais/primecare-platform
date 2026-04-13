class ScheduleOpenHouseFormDto {
  final Map<String, dynamic> rawData;

  ScheduleOpenHouseFormDto({
    required this.rawData,
  });

  factory ScheduleOpenHouseFormDto.fromJson(Map<String, dynamic> json) {
    return ScheduleOpenHouseFormDto(
      rawData: json,
    );
  }

  Map<String, dynamic> toJson() {
    return rawData;
  }
}
