import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/ceo_approvals_model.dart';

class CeoApprovalsNotifier extends StateNotifier<CeoApprovalsModel> {
  CeoApprovalsNotifier() : super(const CeoApprovalsModel(isLoading: true));

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

final ceo_approvalsProvider = StateNotifierProvider<CeoApprovalsNotifier, CeoApprovalsModel>((ref) {
  return CeoApprovalsNotifier()..loadData();
});
