// Layer: 02_MODELS_FOUNDATION
class RightSideLayout3Dto {
  final String id;
  final Map<String, dynamic> raw;

  RightSideLayout3Dto({required this.id, required this.raw});

  factory RightSideLayout3Dto.fromJson(Map<String, dynamic> json) {
    return RightSideLayout3Dto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

