// Layer: 02_MODELS_FOUNDATION
class LeftSideLayout3Dto {
  final String id;
  final Map<String, dynamic> raw;

  LeftSideLayout3Dto({required this.id, required this.raw});

  factory LeftSideLayout3Dto.fromJson(Map<String, dynamic> json) {
    return LeftSideLayout3Dto(id: json['id']?.toString() ?? '', raw: json);
  }
}
