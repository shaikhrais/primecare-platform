import 'package:flutter_riverpod/legacy.dart';
import '../models/cto_reports_model.dart';

class CtoReportsNotifier extends StateNotifier<CtoReportsModel> {
  CtoReportsNotifier() : super(const CtoReportsModel(isLoading: true));

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

final cto_reportsProvider = StateNotifierProvider<CtoReportsNotifier, CtoReportsModel>((ref) {
  return CtoReportsNotifier()..loadData();
});
