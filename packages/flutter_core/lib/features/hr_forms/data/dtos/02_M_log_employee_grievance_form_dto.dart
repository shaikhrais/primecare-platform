// Layer: 02_MODELS_FOUNDATION
class LogEmployeeGrievanceFormDto {
  final Map<String, dynamic> rawData;

  LogEmployeeGrievanceFormDto({required this.rawData});

  factory LogEmployeeGrievanceFormDto.fromJson(Map<String, dynamic> json) {
    return LogEmployeeGrievanceFormDto(rawData: json);
  }

  Map<String, dynamic> toJson() {
    return rawData;
  }
}
