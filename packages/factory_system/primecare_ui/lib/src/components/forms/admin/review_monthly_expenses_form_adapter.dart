import 'package:flutter_riverpod/flutter_riverpod.dart';
// Prisma Load Adapter

class ReviewMonthlyExpensesFormViewModel {
  final bool isLoading;
  final dynamic data;
  ReviewMonthlyExpensesFormViewModel({this.isLoading = false, this.data});
}

class ReviewMonthlyExpensesFormAdapter extends Notifier<ReviewMonthlyExpensesFormViewModel> {
  @override
  ReviewMonthlyExpensesFormViewModel build() {
    return ReviewMonthlyExpensesFormViewModel();
  }
  Future<void> loadData() async {
     // TODO: Prisma API binding
     state = ReviewMonthlyExpensesFormViewModel(isLoading: true, data: state.data);
     // Simulate fetch
     state = ReviewMonthlyExpensesFormViewModel(isLoading: false, data: {});
  }
}

final reviewMonthlyExpensesFormAdapterProvider = NotifierProvider<ReviewMonthlyExpensesFormAdapter, ReviewMonthlyExpensesFormViewModel>(() {
  return ReviewMonthlyExpensesFormAdapter();
});
