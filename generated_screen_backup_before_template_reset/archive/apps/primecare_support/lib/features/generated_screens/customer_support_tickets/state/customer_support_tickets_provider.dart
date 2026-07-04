import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/customer_support_tickets_model.dart';

class CustomerSupportTicketsNotifier extends StateNotifier<CustomerSupportTicketsModel> {
  CustomerSupportTicketsNotifier() : super(const CustomerSupportTicketsModel(isLoading: true));

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

final customer_support_ticketsProvider = StateNotifierProvider<CustomerSupportTicketsNotifier, CustomerSupportTicketsModel>((ref) {
  return CustomerSupportTicketsNotifier()..loadData();
});
