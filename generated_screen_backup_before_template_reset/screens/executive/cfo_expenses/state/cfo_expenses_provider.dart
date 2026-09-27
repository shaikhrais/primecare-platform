import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cfo_expenses_model.dart';

class CfoExpensesNotifier extends StateNotifier<CfoExpensesModel> {
  CfoExpensesNotifier() : super(const CfoExpensesModel(isLoading: true));

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      // TODO: Call API service
      state = state.copyWith(isLoading: false, data: const {});
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final cfo_expensesProvider = StateNotifierProvider<CfoExpensesNotifier, CfoExpensesModel>((ref) {
  return CfoExpensesNotifier()..loadData();
});
