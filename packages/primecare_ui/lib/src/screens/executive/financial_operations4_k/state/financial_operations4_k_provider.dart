import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/financial_operations4_k_model.dart';

class FinancialOperations4KNotifier extends StateNotifier<FinancialOperations4KModel> {
  FinancialOperations4KNotifier() : super(const FinancialOperations4KModel(isLoading: true));

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

final financial_operations4_kProvider = StateNotifierProvider<FinancialOperations4KNotifier, FinancialOperations4KModel>((ref) {
  return FinancialOperations4KNotifier()..loadData();
});
