import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/franchise_owner_reports_model.dart';

class FranchiseOwnerReportsNotifier extends StateNotifier<FranchiseOwnerReportsModel> {
  FranchiseOwnerReportsNotifier() : super(const FranchiseOwnerReportsModel(isLoading: true));

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

final franchise_owner_reportsProvider = StateNotifierProvider<FranchiseOwnerReportsNotifier, FranchiseOwnerReportsModel>((ref) {
  return FranchiseOwnerReportsNotifier()..loadData();
});
