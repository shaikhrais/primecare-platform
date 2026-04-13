class ReviewPeerPerformanceFormDto {
  final Map<String, dynamic> rawData;

  ReviewPeerPerformanceFormDto({
    required this.rawData,
  });

  factory ReviewPeerPerformanceFormDto.fromJson(Map<String, dynamic> json) {
    return ReviewPeerPerformanceFormDto(
      rawData: json,
    );
  }

  Map<String, dynamic> toJson() {
    return rawData;
  }
}
