import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/family_billing_model.dart';

class FamilyBillingNotifier extends StateNotifier<FamilyBillingModel> {
  FamilyBillingNotifier() : super(const FamilyBillingModel(isLoading: true));

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

final family_billingProvider = StateNotifierProvider<FamilyBillingNotifier, FamilyBillingModel>((ref) {
  return FamilyBillingNotifier()..loadData();
});
