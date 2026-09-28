import 'package:flutter_riverpod/legacy.dart';
import '../models/customer_support_reports_model.dart';

class CustomerSupportReportsNotifier extends StateNotifier<CustomerSupportReportsModel> {
  CustomerSupportReportsNotifier() : super(const CustomerSupportReportsModel(isLoading: true));

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

final customer_support_reportsProvider = StateNotifierProvider<CustomerSupportReportsNotifier, CustomerSupportReportsModel>((ref) {
  return CustomerSupportReportsNotifier()..loadData();
});
