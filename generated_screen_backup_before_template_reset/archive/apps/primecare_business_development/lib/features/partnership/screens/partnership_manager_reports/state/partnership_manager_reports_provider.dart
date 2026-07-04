import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/partnership_manager_reports_model.dart';

class PartnershipManagerReportsNotifier extends StateNotifier<PartnershipManagerReportsModel> {
  PartnershipManagerReportsNotifier() : super(const PartnershipManagerReportsModel(isLoading: true));

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

final partnership_manager_reportsProvider = StateNotifierProvider<PartnershipManagerReportsNotifier, PartnershipManagerReportsModel>((ref) {
  return PartnershipManagerReportsNotifier()..loadData();
});
