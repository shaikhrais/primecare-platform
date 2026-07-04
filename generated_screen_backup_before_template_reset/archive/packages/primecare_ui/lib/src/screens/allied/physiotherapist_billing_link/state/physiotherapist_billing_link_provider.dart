import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/physiotherapist_billing_link_model.dart';

class PhysiotherapistBillingLinkNotifier extends StateNotifier<PhysiotherapistBillingLinkModel> {
  PhysiotherapistBillingLinkNotifier() : super(const PhysiotherapistBillingLinkModel(isLoading: true));

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

final physiotherapist_billing_linkProvider = StateNotifierProvider<PhysiotherapistBillingLinkNotifier, PhysiotherapistBillingLinkModel>((ref) {
  return PhysiotherapistBillingLinkNotifier()..loadData();
});
