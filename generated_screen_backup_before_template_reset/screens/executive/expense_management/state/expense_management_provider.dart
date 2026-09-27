import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/expense_management_model.dart';

class ExpenseManagementNotifier extends StateNotifier<ExpenseManagementModel> {
  ExpenseManagementNotifier() : super(const ExpenseManagementModel(isLoading: true));

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

final expense_managementProvider = StateNotifierProvider<ExpenseManagementNotifier, ExpenseManagementModel>((ref) {
  return ExpenseManagementNotifier()..loadData();
});
