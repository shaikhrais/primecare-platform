// Layer: 02_MODELS_FOUNDATION
class RightSideLayout2Dto {
  final String id;
  final Map<String, dynamic> raw;

  RightSideLayout2Dto({required this.id, required this.raw});

  factory RightSideLayout2Dto.fromJson(Map<String, dynamic> json) {
    return RightSideLayout2Dto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

