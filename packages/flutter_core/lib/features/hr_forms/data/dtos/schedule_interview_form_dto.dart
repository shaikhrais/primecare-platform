class ScheduleInterviewFormDto {
  final Map<String, dynamic> rawData;

  ScheduleInterviewFormDto({
    required this.rawData,
  });

  factory ScheduleInterviewFormDto.fromJson(Map<String, dynamic> json) {
    return ScheduleInterviewFormDto(
      rawData: json,
    );
  }

  Map<String, dynamic> toJson() {
    return rawData;
  }
}
