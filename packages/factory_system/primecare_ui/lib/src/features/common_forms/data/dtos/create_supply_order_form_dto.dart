// Layer: 02_MODELS_FOUNDATION
class CreateSupplyOrderFormDto {
  final String id;
  final Map<String, dynamic> raw;

  CreateSupplyOrderFormDto({required this.id, required this.raw});

  factory CreateSupplyOrderFormDto.fromJson(Map<String, dynamic> json) {
    return CreateSupplyOrderFormDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
