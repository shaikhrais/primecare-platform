// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_review_monthly_expenses_form_view_model.dart';
import '../dtos/02_M_review_monthly_expenses_form_dto.dart';

class ReviewMonthlyExpensesFormMapper {
  static ReviewMonthlyExpensesFormViewModel fromDto(
    ReviewMonthlyExpensesFormDto dto,
  ) {
    return ReviewMonthlyExpensesFormViewModel(
      title: dto.raw['title']?.toString() ?? 'reviewMonthlyExpensesForm',
      metadata: dto.raw,
    );
  }
}
