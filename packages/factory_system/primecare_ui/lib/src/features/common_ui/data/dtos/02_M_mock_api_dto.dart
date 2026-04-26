// Layer: 02_MODELS_FOUNDATION
class MockApiDto {
  final String id;
  final Map<String, dynamic> raw;

  MockApiDto({required this.id, required this.raw});

  factory MockApiDto.fromJson(Map<String, dynamic> json) {
    return MockApiDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
