import 'package:flutter_riverpod/legacy.dart';
import '../models/local_marketing_manager_budget_model.dart';

class LocalMarketingManagerBudgetNotifier extends StateNotifier<LocalMarketingManagerBudgetModel> {
  LocalMarketingManagerBudgetNotifier() : super(const LocalMarketingManagerBudgetModel(isLoading: true));

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

final local_marketing_manager_budgetProvider = StateNotifierProvider<LocalMarketingManagerBudgetNotifier, LocalMarketingManagerBudgetModel>((ref) {
  return LocalMarketingManagerBudgetNotifier()..loadData();
});
