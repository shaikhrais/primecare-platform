// Layer: 02_MODELS_FOUNDATION
class LeaveRequestFormDto {
  final Map<String, dynamic> rawData;

  LeaveRequestFormDto({required this.rawData});

  factory LeaveRequestFormDto.fromJson(Map<String, dynamic> json) {
    return LeaveRequestFormDto(rawData: json);
  }

  Map<String, dynamic> toJson() {
    return rawData;
  }
}
