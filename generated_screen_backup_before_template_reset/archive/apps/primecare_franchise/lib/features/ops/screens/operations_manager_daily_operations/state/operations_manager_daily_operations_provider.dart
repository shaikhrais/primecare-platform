import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/operations_manager_daily_operations_model.dart';

class OperationsManagerDailyOperationsNotifier extends StateNotifier<OperationsManagerDailyOperationsModel> {
  OperationsManagerDailyOperationsNotifier() : super(const OperationsManagerDailyOperationsModel(isLoading: true));

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

final operations_manager_daily_operationsProvider = StateNotifierProvider<OperationsManagerDailyOperationsNotifier, OperationsManagerDailyOperationsModel>((ref) {
  return OperationsManagerDailyOperationsNotifier()..loadData();
});
