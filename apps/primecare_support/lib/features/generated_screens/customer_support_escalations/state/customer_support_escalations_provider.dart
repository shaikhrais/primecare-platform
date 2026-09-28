import 'package:flutter_riverpod/legacy.dart';
import '../models/customer_support_escalations_model.dart';

class CustomerSupportEscalationsNotifier extends StateNotifier<CustomerSupportEscalationsModel> {
  CustomerSupportEscalationsNotifier() : super(const CustomerSupportEscalationsModel(isLoading: true));

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

final customer_support_escalationsProvider = StateNotifierProvider<CustomerSupportEscalationsNotifier, CustomerSupportEscalationsModel>((ref) {
  return CustomerSupportEscalationsNotifier()..loadData();
});
