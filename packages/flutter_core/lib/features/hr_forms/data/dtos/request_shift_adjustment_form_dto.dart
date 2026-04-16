class RequestShiftAdjustmentFormDto {
  final Map<String, dynamic> rawData;

  RequestShiftAdjustmentFormDto({required this.rawData});

  factory RequestShiftAdjustmentFormDto.fromJson(Map<String, dynamic> json) {
    return RequestShiftAdjustmentFormDto(rawData: json);
  }

  Map<String, dynamic> toJson() {
    return rawData;
  }
}
