class LogFranchiseeVettingCallFormDto {
  final Map<String, dynamic> rawData;

  LogFranchiseeVettingCallFormDto({
    required this.rawData,
  });

  factory LogFranchiseeVettingCallFormDto.fromJson(Map<String, dynamic> json) {
    return LogFranchiseeVettingCallFormDto(
      rawData: json,
    );
  }

  Map<String, dynamic> toJson() {
    return rawData;
  }
}
