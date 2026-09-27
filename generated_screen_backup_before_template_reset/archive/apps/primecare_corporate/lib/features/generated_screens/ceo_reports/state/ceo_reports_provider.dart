import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/ceo_reports_model.dart';

class CeoReportsNotifier extends StateNotifier<CeoReportsModel> {
  CeoReportsNotifier() : super(const CeoReportsModel(isLoading: true));

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

final ceo_reportsProvider = StateNotifierProvider<CeoReportsNotifier, CeoReportsModel>((ref) {
  return CeoReportsNotifier()..loadData();
});
