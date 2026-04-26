// Layer: 02_MODELS_FOUNDATION
class FooterLayout3Dto {
  final String id;
  final Map<String, dynamic> raw;

  FooterLayout3Dto({required this.id, required this.raw});

  factory FooterLayout3Dto.fromJson(Map<String, dynamic> json) {
    return FooterLayout3Dto(id: json['id']?.toString() ?? '', raw: json);
  }
}
