import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/financial_forecasting_model_model.dart';

class FinancialForecastingModelNotifier extends StateNotifier<FinancialForecastingModelModel> {
  FinancialForecastingModelNotifier() : super(const FinancialForecastingModelModel(isLoading: true));

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

final financial_forecasting_modelProvider = StateNotifierProvider<FinancialForecastingModelNotifier, FinancialForecastingModelModel>((ref) {
  return FinancialForecastingModelNotifier()..loadData();
});
