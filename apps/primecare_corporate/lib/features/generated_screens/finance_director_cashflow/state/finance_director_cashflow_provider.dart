import 'package:flutter_riverpod/legacy.dart';
import '../models/finance_director_cashflow_model.dart';

class FinanceDirectorCashflowNotifier extends StateNotifier<FinanceDirectorCashflowModel> {
  FinanceDirectorCashflowNotifier() : super(const FinanceDirectorCashflowModel(isLoading: true));

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      // TODO: Call API service
      state = state.copyWith(isLoading: false, data: const <String, dynamic>{});
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final finance_director_cashflowProvider = StateNotifierProvider<FinanceDirectorCashflowNotifier, FinanceDirectorCashflowModel>((ref) {
  return FinanceDirectorCashflowNotifier()..loadData();
});
