import 'package:flutter_riverpod/legacy.dart';
import '../models/proposals_model.dart';

class ProposalsNotifier extends StateNotifier<ProposalsModel> {
  ProposalsNotifier() : super(const ProposalsModel(isLoading: true));

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

final proposalsProvider = StateNotifierProvider<ProposalsNotifier, ProposalsModel>((ref) {
  return ProposalsNotifier()..loadData();
});
