import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/rmt_billing_link_model.dart';

class RmtBillingLinkNotifier extends StateNotifier<RmtBillingLinkModel> {
  RmtBillingLinkNotifier() : super(const RmtBillingLinkModel(isLoading: true));

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

final rmt_billing_linkProvider = StateNotifierProvider<RmtBillingLinkNotifier, RmtBillingLinkModel>((ref) {
  return RmtBillingLinkNotifier()..loadData();
});
