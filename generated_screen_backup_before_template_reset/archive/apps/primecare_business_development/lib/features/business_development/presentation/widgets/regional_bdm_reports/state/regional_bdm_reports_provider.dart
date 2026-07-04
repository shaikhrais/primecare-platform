import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/regional_bdm_reports_model.dart';

class RegionalBdmReportsNotifier extends StateNotifier<RegionalBdmReportsModel> {
  RegionalBdmReportsNotifier() : super(const RegionalBdmReportsModel(isLoading: true));

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

final regional_bdm_reportsProvider = StateNotifierProvider<RegionalBdmReportsNotifier, RegionalBdmReportsModel>((ref) {
  return RegionalBdmReportsNotifier()..loadData();
});
