// Layer: 02_MODELS_FOUNDATION
class ReviewPeerPerformanceFormDto {
  final String id;
  final Map<String, dynamic> raw;

  ReviewPeerPerformanceFormDto({required this.id, required this.raw});

  factory ReviewPeerPerformanceFormDto.fromJson(Map<String, dynamic> json) {
    return ReviewPeerPerformanceFormDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
