import 'package:flutter_riverpod/legacy.dart';
import '../models/coo_reports_model.dart';

class CooReportsNotifier extends StateNotifier<CooReportsModel> {
  CooReportsNotifier() : super(const CooReportsModel(isLoading: true));

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

final coo_reportsProvider = StateNotifierProvider<CooReportsNotifier, CooReportsModel>((ref) {
  return CooReportsNotifier()..loadData();
});
