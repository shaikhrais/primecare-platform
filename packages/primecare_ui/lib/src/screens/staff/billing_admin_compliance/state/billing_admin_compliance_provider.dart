import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/billing_admin_compliance_model.dart';

class BillingAdminComplianceNotifier extends StateNotifier<BillingAdminComplianceModel> {
  BillingAdminComplianceNotifier() : super(const BillingAdminComplianceModel(isLoading: true));

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

final billing_admin_complianceProvider = StateNotifierProvider<BillingAdminComplianceNotifier, BillingAdminComplianceModel>((ref) {
  return BillingAdminComplianceNotifier()..loadData();
});
