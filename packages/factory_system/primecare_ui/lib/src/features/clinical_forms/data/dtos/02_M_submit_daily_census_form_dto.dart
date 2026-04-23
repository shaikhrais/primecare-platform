// Layer: 02_MODELS_FOUNDATION
class SubmitDailyCensusFormDto {
  final String id;
  final Map<String, dynamic> raw;

  SubmitDailyCensusFormDto({required this.id, required this.raw});

  factory SubmitDailyCensusFormDto.fromJson(Map<String, dynamic> json) {
    return SubmitDailyCensusFormDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

