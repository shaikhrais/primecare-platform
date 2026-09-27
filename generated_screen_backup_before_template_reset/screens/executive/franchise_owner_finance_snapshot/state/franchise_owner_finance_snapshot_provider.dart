import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/franchise_owner_finance_snapshot_model.dart';

class FranchiseOwnerFinanceSnapshotNotifier extends StateNotifier<FranchiseOwnerFinanceSnapshotModel> {
  FranchiseOwnerFinanceSnapshotNotifier() : super(const FranchiseOwnerFinanceSnapshotModel(isLoading: true));

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

final franchise_owner_finance_snapshotProvider = StateNotifierProvider<FranchiseOwnerFinanceSnapshotNotifier, FranchiseOwnerFinanceSnapshotModel>((ref) {
  return FranchiseOwnerFinanceSnapshotNotifier()..loadData();
});
