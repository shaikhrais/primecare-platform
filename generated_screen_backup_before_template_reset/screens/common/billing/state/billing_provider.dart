import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/billing_model.dart';

class BillingNotifier extends StateNotifier<BillingModel> {
  BillingNotifier() : super(const BillingModel(isLoading: true));

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

final billingProvider = StateNotifierProvider<BillingNotifier, BillingModel>((ref) {
  return BillingNotifier()..loadData();
});
