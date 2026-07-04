import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/coo_operations_overview_model.dart';

class CooOperationsOverviewNotifier extends StateNotifier<CooOperationsOverviewModel> {
  CooOperationsOverviewNotifier() : super(const CooOperationsOverviewModel(isLoading: true));

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

final coo_operations_overviewProvider = StateNotifierProvider<CooOperationsOverviewNotifier, CooOperationsOverviewModel>((ref) {
  return CooOperationsOverviewNotifier()..loadData();
});
