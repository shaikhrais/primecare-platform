// Layer: 02_MODELS_FOUNDATION
class MasterLayoutDto {
  final String id;
  final Map<String, dynamic> raw;

  MasterLayoutDto({required this.id, required this.raw});

  factory MasterLayoutDto.fromJson(Map<String, dynamic> json) {
    return MasterLayoutDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

