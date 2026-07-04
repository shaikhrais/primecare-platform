import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/daily_operations_model.dart';

class DailyOperationsNotifier extends StateNotifier<DailyOperationsModel> {
  DailyOperationsNotifier() : super(const DailyOperationsModel(isLoading: true));

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

final daily_operationsProvider = StateNotifierProvider<DailyOperationsNotifier, DailyOperationsModel>((ref) {
  return DailyOperationsNotifier()..loadData();
});
