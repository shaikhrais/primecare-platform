import 'package:flutter_riverpod/legacy.dart';
import '../models/operations_manager_reports_model.dart';

class OperationsManagerReportsNotifier extends StateNotifier<OperationsManagerReportsModel> {
  OperationsManagerReportsNotifier() : super(const OperationsManagerReportsModel(isLoading: true));

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

final operations_manager_reportsProvider = StateNotifierProvider<OperationsManagerReportsNotifier, OperationsManagerReportsModel>((ref) {
  return OperationsManagerReportsNotifier()..loadData();
});
