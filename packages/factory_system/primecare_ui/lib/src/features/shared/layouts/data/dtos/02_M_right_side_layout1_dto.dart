// Layer: 02_MODELS_FOUNDATION
class RightSideLayout1Dto {
  final String id;
  final Map<String, dynamic> raw;

  RightSideLayout1Dto({required this.id, required this.raw});

  factory RightSideLayout1Dto.fromJson(Map<String, dynamic> json) {
    return RightSideLayout1Dto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

