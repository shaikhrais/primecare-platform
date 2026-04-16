class SubmitExitInterviewFormDto {
  final Map<String, dynamic> rawData;

  SubmitExitInterviewFormDto({required this.rawData});

  factory SubmitExitInterviewFormDto.fromJson(Map<String, dynamic> json) {
    return SubmitExitInterviewFormDto(rawData: json);
  }

  Map<String, dynamic> toJson() {
    return rawData;
  }
}
