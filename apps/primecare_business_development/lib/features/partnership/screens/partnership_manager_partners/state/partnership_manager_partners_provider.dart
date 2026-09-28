import 'package:flutter_riverpod/legacy.dart';
import '../models/partnership_manager_partners_model.dart';

class PartnershipManagerPartnersNotifier extends StateNotifier<PartnershipManagerPartnersModel> {
  PartnershipManagerPartnersNotifier() : super(const PartnershipManagerPartnersModel(isLoading: true));

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

final partnership_manager_partnersProvider = StateNotifierProvider<PartnershipManagerPartnersNotifier, PartnershipManagerPartnersModel>((ref) {
  return PartnershipManagerPartnersNotifier()..loadData();
});
