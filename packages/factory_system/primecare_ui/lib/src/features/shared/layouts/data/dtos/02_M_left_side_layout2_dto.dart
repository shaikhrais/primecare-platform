// Layer: 02_MODELS_FOUNDATION
class LeftSideLayout2Dto {
  final String id;
  final Map<String, dynamic> raw;

  LeftSideLayout2Dto({required this.id, required this.raw});

  factory LeftSideLayout2Dto.fromJson(Map<String, dynamic> json) {
    return LeftSideLayout2Dto(id: json['id']?.toString() ?? '', raw: json);
  }
}
