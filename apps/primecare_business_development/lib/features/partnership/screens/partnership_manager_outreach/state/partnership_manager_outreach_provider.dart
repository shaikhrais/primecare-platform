import 'package:flutter_riverpod/legacy.dart';
import '../models/partnership_manager_outreach_model.dart';

class PartnershipManagerOutreachNotifier extends StateNotifier<PartnershipManagerOutreachModel> {
  PartnershipManagerOutreachNotifier() : super(const PartnershipManagerOutreachModel(isLoading: true));

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

final partnership_manager_outreachProvider = StateNotifierProvider<PartnershipManagerOutreachNotifier, PartnershipManagerOutreachModel>((ref) {
  return PartnershipManagerOutreachNotifier()..loadData();
});
