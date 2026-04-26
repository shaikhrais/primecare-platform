// Layer: 02_MODELS_FOUNDATION
class ApproveLeaveRequestFormDto {
  final String id;
  final Map<String, dynamic> raw;

  ApproveLeaveRequestFormDto({required this.id, required this.raw});

  factory ApproveLeaveRequestFormDto.fromJson(Map<String, dynamic> json) {
    return ApproveLeaveRequestFormDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
