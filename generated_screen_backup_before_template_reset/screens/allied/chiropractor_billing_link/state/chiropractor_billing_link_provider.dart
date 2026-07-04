import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/chiropractor_billing_link_model.dart';

class ChiropractorBillingLinkNotifier extends StateNotifier<ChiropractorBillingLinkModel> {
  ChiropractorBillingLinkNotifier() : super(const ChiropractorBillingLinkModel(isLoading: true));

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

final chiropractor_billing_linkProvider = StateNotifierProvider<ChiropractorBillingLinkNotifier, ChiropractorBillingLinkModel>((ref) {
  return ChiropractorBillingLinkNotifier()..loadData();
});
