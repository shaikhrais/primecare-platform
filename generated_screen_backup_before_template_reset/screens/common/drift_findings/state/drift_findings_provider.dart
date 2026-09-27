import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/drift_findings_model.dart';

class DriftFindingsNotifier extends StateNotifier<DriftFindingsModel> {
  DriftFindingsNotifier() : super(const DriftFindingsModel(isLoading: true));

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

final drift_findingsProvider = StateNotifierProvider<DriftFindingsNotifier, DriftFindingsModel>((ref) {
  return DriftFindingsNotifier()..loadData();
});
