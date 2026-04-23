// Layer: 02_MODELS_FOUNDATION
class ApproveSystemAccessFormDto {
  final String id;
  final Map<String, dynamic> raw;

  ApproveSystemAccessFormDto({required this.id, required this.raw});

  factory ApproveSystemAccessFormDto.fromJson(Map<String, dynamic> json) {
    return ApproveSystemAccessFormDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

