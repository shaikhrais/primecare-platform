// Layer: 02_MODELS_FOUNDATION
class ReviewMarketShareFormDto {
  final Map<String, dynamic> rawData;

  ReviewMarketShareFormDto({required this.rawData});

  factory ReviewMarketShareFormDto.fromJson(Map<String, dynamic> json) {
    return ReviewMarketShareFormDto(rawData: json);
  }

  Map<String, dynamic> toJson() {
    return rawData;
  }
}
