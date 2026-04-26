// Layer: 02_MODELS_FOUNDATION
class FooterLayout1Dto {
  final String id;
  final Map<String, dynamic> raw;

  FooterLayout1Dto({required this.id, required this.raw});

  factory FooterLayout1Dto.fromJson(Map<String, dynamic> json) {
    return FooterLayout1Dto(id: json['id']?.toString() ?? '', raw: json);
  }
}
