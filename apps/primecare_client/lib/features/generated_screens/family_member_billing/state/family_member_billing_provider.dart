import 'package:flutter_riverpod/legacy.dart';
import '../models/family_member_billing_model.dart';

class FamilyMemberBillingNotifier extends StateNotifier<FamilyMemberBillingModel> {
  FamilyMemberBillingNotifier() : super(const FamilyMemberBillingModel(isLoading: true));

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

final family_member_billingProvider = StateNotifierProvider<FamilyMemberBillingNotifier, FamilyMemberBillingModel>((ref) {
  return FamilyMemberBillingNotifier()..loadData();
});
