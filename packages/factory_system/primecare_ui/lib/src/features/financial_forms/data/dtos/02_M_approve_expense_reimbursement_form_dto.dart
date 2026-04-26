// Layer: 02_MODELS_FOUNDATION
class ApproveExpenseReimbursementFormDto {
  final String id;
  final Map<String, dynamic> raw;

  ApproveExpenseReimbursementFormDto({required this.id, required this.raw});

  factory ApproveExpenseReimbursementFormDto.fromJson(
    Map<String, dynamic> json,
  ) {
    return ApproveExpenseReimbursementFormDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
