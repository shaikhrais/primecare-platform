import 'package:flutter_riverpod/legacy.dart';
import '../models/partnership_manager_renewals_model.dart';

class PartnershipManagerRenewalsNotifier extends StateNotifier<PartnershipManagerRenewalsModel> {
  PartnershipManagerRenewalsNotifier() : super(const PartnershipManagerRenewalsModel(isLoading: true));

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

final partnership_manager_renewalsProvider = StateNotifierProvider<PartnershipManagerRenewalsNotifier, PartnershipManagerRenewalsModel>((ref) {
  return PartnershipManagerRenewalsNotifier()..loadData();
});
