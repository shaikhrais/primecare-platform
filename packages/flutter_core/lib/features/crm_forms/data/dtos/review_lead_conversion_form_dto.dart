class ReviewLeadConversionFormDto {
  final Map<String, dynamic> rawData;

  ReviewLeadConversionFormDto({
    required this.rawData,
  });

  factory ReviewLeadConversionFormDto.fromJson(Map<String, dynamic> json) {
    return ReviewLeadConversionFormDto(
      rawData: json,
    );
  }

  Map<String, dynamic> toJson() {
    return rawData;
  }
}
