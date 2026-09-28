import 'package:flutter_riverpod/legacy.dart';
import '../models/coo_branch_operations_model.dart';

class CooBranchOperationsNotifier extends StateNotifier<CooBranchOperationsModel> {
  CooBranchOperationsNotifier() : super(const CooBranchOperationsModel(isLoading: true));

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      // TODO: Call API service
      state = state.copyWith(isLoading: false, data: const <String, dynamic>{});
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final coo_branch_operationsProvider = StateNotifierProvider<CooBranchOperationsNotifier, CooBranchOperationsModel>((ref) {
  return CooBranchOperationsNotifier()..loadData();
});
