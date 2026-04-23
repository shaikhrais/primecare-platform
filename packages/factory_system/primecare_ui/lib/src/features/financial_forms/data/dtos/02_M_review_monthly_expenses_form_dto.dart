// Layer: 02_MODELS_FOUNDATION
class ReviewMonthlyExpensesFormDto {
  final String id;
  final Map<String, dynamic> raw;

  ReviewMonthlyExpensesFormDto({required this.id, required this.raw});

  factory ReviewMonthlyExpensesFormDto.fromJson(Map<String, dynamic> json) {
    return ReviewMonthlyExpensesFormDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

