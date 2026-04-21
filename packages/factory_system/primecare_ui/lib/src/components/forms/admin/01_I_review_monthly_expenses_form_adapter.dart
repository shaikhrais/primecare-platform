// Layer: 01_INFRASTRUCTURE
import 'package:primecare_core/00_B_flutter_core.dart';

// Prisma Load Adapter

class ReviewMonthlyExpensesFormViewModel {
  final bool isLoading;
  final Map<String, dynamic>? data;
  ReviewMonthlyExpensesFormViewModel({this.isLoading = false, this.data});
}

class ReviewMonthlyExpensesFormAdapter
    extends Notifier<ReviewMonthlyExpensesFormViewModel> {
  @override
  ReviewMonthlyExpensesFormViewModel build() {
    return ReviewMonthlyExpensesFormViewModel();
  }

  Future<void> loadData() async {
        state = ReviewMonthlyExpensesFormViewModel(isLoading: true, data: state.data);
    try {
      final client = ref.read(apiClientProvider);
      final response = await client.get('/api/v1/review-monthly-expenses-form-adapter');
      state = ReviewMonthlyExpensesFormViewModel(isLoading: false, data: response.data as Map<String, dynamic>?);
    } catch (e) {
      // Fallback
      state = ReviewMonthlyExpensesFormViewModel(isLoading: false, data: <String, dynamic>{});
    }
  }
}

final reviewMonthlyExpensesFormAdapterProvider =
    NotifierProvider<
      ReviewMonthlyExpensesFormAdapter,
      ReviewMonthlyExpensesFormViewModel
    >(() {
      return ReviewMonthlyExpensesFormAdapter();
    });
