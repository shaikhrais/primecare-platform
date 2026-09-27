import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/revenue_snapshot_model.dart';

class RevenueSnapshotNotifier extends StateNotifier<RevenueSnapshotModel> {
  RevenueSnapshotNotifier() : super(const RevenueSnapshotModel(isLoading: true));

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

final revenue_snapshotProvider = StateNotifierProvider<RevenueSnapshotNotifier, RevenueSnapshotModel>((ref) {
  return RevenueSnapshotNotifier()..loadData();
});
