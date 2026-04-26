// Layer: 02_MODELS_FOUNDATION
class CreateCustomInvoiceFormDto {
  final String id;
  final Map<String, dynamic> raw;

  CreateCustomInvoiceFormDto({required this.id, required this.raw});

  factory CreateCustomInvoiceFormDto.fromJson(Map<String, dynamic> json) {
    return CreateCustomInvoiceFormDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
