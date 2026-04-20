import 'package:primecare_core/flutter_core.dart';

// Prisma Load Adapter

class ReviewMonthlyExpensesFormViewModel {
  final bool isLoading;
  final dynamic data;
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
      state = ReviewMonthlyExpensesFormViewModel(isLoading: false, data: response);
    } catch (e) {
      // Fallback
      state = ReviewMonthlyExpensesFormViewModel(isLoading: false, data: {});
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
