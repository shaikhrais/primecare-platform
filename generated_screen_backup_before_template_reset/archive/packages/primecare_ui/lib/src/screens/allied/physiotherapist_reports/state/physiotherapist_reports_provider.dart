import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/physiotherapist_reports_model.dart';

class PhysiotherapistReportsNotifier extends StateNotifier<PhysiotherapistReportsModel> {
  PhysiotherapistReportsNotifier() : super(const PhysiotherapistReportsModel(isLoading: true));

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

final physiotherapist_reportsProvider = StateNotifierProvider<PhysiotherapistReportsNotifier, PhysiotherapistReportsModel>((ref) {
  return PhysiotherapistReportsNotifier()..loadData();
});
