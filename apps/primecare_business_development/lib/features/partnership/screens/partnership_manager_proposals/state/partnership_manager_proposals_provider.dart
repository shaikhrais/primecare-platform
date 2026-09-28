import 'package:flutter_riverpod/legacy.dart';
import '../models/partnership_manager_proposals_model.dart';

class PartnershipManagerProposalsNotifier extends StateNotifier<PartnershipManagerProposalsModel> {
  PartnershipManagerProposalsNotifier() : super(const PartnershipManagerProposalsModel(isLoading: true));

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

final partnership_manager_proposalsProvider = StateNotifierProvider<PartnershipManagerProposalsNotifier, PartnershipManagerProposalsModel>((ref) {
  return PartnershipManagerProposalsNotifier()..loadData();
});
