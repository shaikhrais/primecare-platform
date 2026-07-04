import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/customer_support_compliance_model.dart';

class CustomerSupportComplianceNotifier extends StateNotifier<CustomerSupportComplianceModel> {
  CustomerSupportComplianceNotifier() : super(const CustomerSupportComplianceModel(isLoading: true));

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

final customer_support_complianceProvider = StateNotifierProvider<CustomerSupportComplianceNotifier, CustomerSupportComplianceModel>((ref) {
  return CustomerSupportComplianceNotifier()..loadData();
});
