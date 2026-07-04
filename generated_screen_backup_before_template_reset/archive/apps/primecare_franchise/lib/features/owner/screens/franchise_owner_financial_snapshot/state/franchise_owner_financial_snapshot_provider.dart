import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/franchise_owner_financial_snapshot_model.dart';

class FranchiseOwnerFinancialSnapshotNotifier extends StateNotifier<FranchiseOwnerFinancialSnapshotModel> {
  FranchiseOwnerFinancialSnapshotNotifier() : super(const FranchiseOwnerFinancialSnapshotModel(isLoading: true));

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

final franchise_owner_financial_snapshotProvider = StateNotifierProvider<FranchiseOwnerFinancialSnapshotNotifier, FranchiseOwnerFinancialSnapshotModel>((ref) {
  return FranchiseOwnerFinancialSnapshotNotifier()..loadData();
});
