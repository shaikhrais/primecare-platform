import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/billing_claims_model.dart';

class BillingClaimsNotifier extends StateNotifier<BillingClaimsModel> {
  BillingClaimsNotifier() : super(const BillingClaimsModel(isLoading: true));

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

final billing_claimsProvider = StateNotifierProvider<BillingClaimsNotifier, BillingClaimsModel>((ref) {
  return BillingClaimsNotifier()..loadData();
});
