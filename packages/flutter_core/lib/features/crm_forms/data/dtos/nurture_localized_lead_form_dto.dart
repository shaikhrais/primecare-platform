class NurtureLocalizedLeadFormDto {
  final Map<String, dynamic> rawData;

  NurtureLocalizedLeadFormDto({
    required this.rawData,
  });

  factory NurtureLocalizedLeadFormDto.fromJson(Map<String, dynamic> json) {
    return NurtureLocalizedLeadFormDto(
      rawData: json,
    );
  }

  Map<String, dynamic> toJson() {
    return rawData;
  }
}
