// Layer: 02_MODELS_FOUNDATION
class LeaveRequestFormDto {
  final String id;
  final Map<String, dynamic> raw;

  LeaveRequestFormDto({required this.id, required this.raw});

  factory LeaveRequestFormDto.fromJson(Map<String, dynamic> json) {
    return LeaveRequestFormDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

